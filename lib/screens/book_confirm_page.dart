import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/bloc/ticket_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/entities/user.dart' as User2;
import 'package:movie_app/screens/e-wallet_page.dart';
import 'package:movie_app/screens/pages.dart';
import 'package:movie_app/services/movie_services.dart';
import 'dart:math';

import 'package:movie_app/temp.dart';

class BookConfirmPage extends StatelessWidget {
  BookConfirmPage({super.key});

  final formatDate = DateFormat('EEE, d MMMM y');
  final formatTime = DateFormat.Hm();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users = firestore.collection('users');
  late CollectionReference transaction = firestore.collection('transaction');
  final userId = FirebaseAuth.instance.currentUser?.uid;

  late User2.User user;

  @override
  Widget build(BuildContext context) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    String orderID = getRandomString(10);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: const Text("Checkout Movie"),
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: BlocBuilder<TicketBloc, TicketState>(
                builder: (context, state) {
                  return BlocBuilder<MovieBloc, MovieState>(
                    builder: (context, stateMovie) {
                      return GestureDetector(
                        onTap: () async {
                          int total = state.when(
                              initial: () => 0,
                              running: (ticket) =>
                                  (ticket.seats!.length * 30000) +
                                  (ticket.seats!.length * 1500));
                          if ((user.balance! - total).isNegative) {
                            showWarning(context, "Please top up first.");
                          } else {
                            showProgress(context);
                            await FirebaseFirestore.instance
                                .collection('tickets')
                                .doc(orderID)
                                .set({
                              'order_id': orderID,
                              'user_id': userId,
                              'movie_id': stateMovie.when(
                                  initial: () => "0", running: (id) => '$id'),
                              'date': state.when(
                                  initial: () => "",
                                  running: (ticket) => ticket.date),
                              'location': state.when(
                                  initial: () => "",
                                  running: (ticket) => ticket.location),
                              'seats': state.when(
                                  initial: () => "",
                                  running: (ticket) => ticket.seats),
                              'price_per_seat': 30000
                            });

                            await users.doc(userId).update({
                              'balance': user.balance! - total
                            }).then((value) async {
                              await transaction.add({
                                'amount': total,
                                'date': DateTime.now(),
                                'name': stateMovie.when(
                                    initial: () => "0", running: (id) => '$id'),
                                'type': 'sent',
                                'user_id': userId
                              }).then((value2) {
                                Navigator.pop(context);
                                Timer(const Duration(milliseconds: 300),
                                    () => showSuccess(context));
                              });
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(color: Colors.red.shade600),
                          child: const Text(
                            "Checkout",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: ListView(
                children: [
                  BlocBuilder<MovieBloc, MovieState>(
                    builder: (context, state) {
                      return FutureBuilder(
                          future: MovieServices.getMovie(state.when(
                              initial: () => "0", running: (id) => '$id')),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              double? rating = snapshot.data?.vote_average;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "http://image.tmdb.org/t/p/w500/${snapshot.data?.poster_path}",
                                        height: 120,
                                        width: 80,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data?.title ?? "",
                                            style: kHeadline2,
                                          ),
                                          Text(
                                            snapshot.data?.genres
                                                    .map((e) => e.name)
                                                    .join(", ") ??
                                                "",
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: kBodyText3,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              RatingBar(
                                                initialRating: rating! / 2,
                                                minRating: 1,
                                                itemSize: 20,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    const EdgeInsets.only(
                                                        right: 5.0),
                                                onRatingUpdate: (_) {},
                                                ratingWidget: RatingWidget(
                                                    full: const Icon(
                                                        Icons.star_rounded,
                                                        color: Colors.amber),
                                                    half: ShaderMask(
                                                      blendMode:
                                                          BlendMode.srcATop,
                                                      shaderCallback:
                                                          (Rect rect) {
                                                        return LinearGradient(
                                                                stops: const [
                                                              0,
                                                              0.5,
                                                              0.5
                                                            ],
                                                                colors: [
                                                              Colors.amber,
                                                              Colors.amber,
                                                              Colors.amber
                                                                  .withOpacity(
                                                                      0)
                                                            ])
                                                            .createShader(rect);
                                                      },
                                                      child: Icon(
                                                        Icons.star_rounded,
                                                        color: Colors
                                                            .grey.shade600,
                                                      ),
                                                    ),
                                                    empty: Icon(
                                                        Icons.star_rounded,
                                                        color: Colors
                                                            .grey.shade600)),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${rating.toStringAsFixed(1)} / 10",
                                                style: kBodyText3,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          });
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Booking Information",
                      style: kHeadline2,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<TicketBloc, TicketState>(
                      builder: (context, state) {
                    var total = state.when(
                        initial: () => "",
                        running: (ticket) => NumberFormat.currency(
                                locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                            .format((ticket.seats!.length * 30000) +
                                (ticket.seats!.length * 1500)));
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Order ID",
                                style: kBodyText,
                              ),
                              Text(
                                orderID,
                                style: kBodyText3,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Cinema",
                                style: kBodyText,
                              ),
                              Text(
                                state.when(
                                    initial: () => "",
                                    running: (ticket) =>
                                        ticket.location.toString()),
                                style: kBodyText3,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Date",
                                style: kBodyText,
                              ),
                              Text(
                                state.when(
                                    initial: () => "",
                                    running: (ticket) => formatDate
                                        .format(ticket.date!.toDate())),
                                style: kBodyText3,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Time",
                                style: kBodyText,
                              ),
                              Text(
                                state.when(
                                    initial: () => "",
                                    running: (ticket) => formatTime
                                        .format(ticket.date!.toDate())),
                                style: kBodyText3,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Seat Numbers",
                                style: kBodyText,
                              ),
                              Text(
                                state.when(
                                    initial: () => "",
                                    running: (ticket) {
                                      List<String> seatNumbers =
                                          List.from(ticket.seats!);
                                      seatNumbers.sort();
                                      return seatNumbers.join(", ");
                                    }),
                                style: kBodyText3,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Price",
                                style: kBodyText,
                              ),
                              Text(
                                state.when(
                                    initial: () => "",
                                    running: (ticket) =>
                                        "Rp 30.000 x ${ticket.seats!.length}"),
                                style: kBodyText3,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Admin Fee",
                                style: kBodyText,
                              ),
                              Text(
                                state.when(
                                    initial: () => "",
                                    running: (ticket) =>
                                        "Rp 1.500 x ${ticket.seats!.length}"),
                                style: kBodyText3,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total",
                                style: kBodyText,
                              ),
                              Text(
                                total,
                                style: kBodyText4,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 1,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Payment",
                              style: kHeadline2,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                  width: 60,
                                  child: Icon(Icons.wallet,
                                      color: Colors.white, size: 40)),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "E-Wallet",
                                    style: kBodyText3,
                                  ),
                                  FutureBuilder<DocumentSnapshot>(
                                      future: users.doc(userId).get(),
                                      builder: (_, snapshot) {
                                        if (snapshot.hasData) {
                                          user = User2.User.fromJson(
                                              snapshot.data!.data()
                                                  as Map<String, dynamic>);
                                          return Text(
                                            NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: 'Rp ',
                                                    decimalDigits: 0)
                                                .format(user.balance!),
                                            style: kBodyText,
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      }),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ));
  }

  void showSuccess(BuildContext context) {
    AwesomeDialog(
      titleTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      descTextStyle: const TextStyle(color: Colors.white),
      title: 'Book Successful!',
      dialogBackgroundColor: kBackgroundColor,
      width: MediaQuery.of(context).size.width,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      onDismissCallback: (_) {
        Timer(const Duration(milliseconds: 300), () {
          indexPage = 1;
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => Pages(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
        });
      },
      btnOkOnPress: () {},
      btnOkText: "Return to History",
    ).show();
  }

  void showProgress(BuildContext context) {
    AwesomeDialog(
        dialogBackgroundColor: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        context: context,
        dialogType: DialogType.noHeader,
        animType: AnimType.bottomSlide,
        body: const SizedBox(
          height: 120,
          child: Center(child: CircularProgressIndicator()),
        )).show();
  }

  void showWarning(BuildContext context, String message) {
    AwesomeDialog(
      dialogBackgroundColor: kBackgroundColor,
      titleTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      descTextStyle: const TextStyle(color: Colors.white),
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Insufficient balance.',
      desc: message,
      btnCancelOnPress: () {},
      onDismissCallback: (type) {
        // Navigator.of(context).popUntil((route) => route.isFirst);
      },
      btnOkOnPress: () {
        Timer(const Duration(milliseconds: 300), () {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => EWalletPage()));
        });
      },
      btnOkText: "OK",
    ).show();
  }
}
