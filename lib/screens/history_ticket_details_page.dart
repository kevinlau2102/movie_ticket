import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/bloc/ticket_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/services/movie_services.dart';
import 'package:movie_app/widgets/separator.dart';

class HistoryTicketDetailsPage extends StatelessWidget {
  HistoryTicketDetailsPage({super.key});

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users = firestore.collection('users');
  final userId = FirebaseAuth.instance.currentUser?.uid;

  final formatDate = DateFormat('EEE, d MMMM y');
  final formatTime = DateFormat.Hm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text("Ticket Details"),
      ),
      body: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          return FutureBuilder(
              future: MovieServices.getMovie(state.when(
                  initial: () => "0",
                  running: (ticket) => ticket.movie_id.toString())),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Stack(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height - 300,
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 30),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 270,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10.0),
                                            child: FutureBuilder(
                                                future: MovieServices.getMovie(
                                                    state.when(
                                                        initial: () => "0",
                                                        running: (ticket) => ticket
                                                            .movie_id
                                                            .toString())),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        snapshot.data?.title ?? "",
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    );
                                                  } else {
                                                    return const SizedBox(
                                                      height: 30,
                                                    );
                                                  }
                                                })),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 25.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ticketDetailsWidget(
                                                "Date",
                                                state.when(
                                                    initial: () => "",
                                                    running: (ticket) =>
                                                        formatDate.format(
                                                            ticket.date!.toDate())),
                                                "Time",
                                                state.when(
                                                    initial: () => "",
                                                    running: (ticket) =>
                                                        formatTime.format(
                                                            ticket.date!.toDate())),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 25.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ticketDetailsWidget(
                                                "Cinema",
                                                state.when(
                                                    initial: () => "",
                                                    running: (ticket) =>
                                                        ticket.location.toString()),
                                                "Seats",
                                                state.when(
                                                    initial: () => "",
                                                    running: (ticket) {
                                                      List<String> seatNumbers =
                                                          List.from(ticket.seats!);
                                                      seatNumbers.sort();
                                                      return seatNumbers.join(", ");
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 160,
                                          padding: const EdgeInsets.only(
                                              left: 12.0, top: 25),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const Text(
                                                "Order ID",
                                                style: TextStyle(color: Colors.grey),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 4.0),
                                                child: Text(
                                                  state.when(
                                                      initial: () => "",
                                                      running: (ticket) =>
                                                          ticket.order_id.toString()),
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 80),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 160,
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const Text(
                                                "Name",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: FutureBuilder(
                                                    future:
                                                        users.doc(userId).get(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Text(
                                                          snapshot
                                                              .data!['name'],
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                        );
                                                      } else {
                                                        return const SizedBox();
                                                      }
                                                    }),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                "Price",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Text(
                                                  state.when(
                                                      initial: () => "",
                                                      running: (ticket) =>
                                                          NumberFormat.currency(
                                                                  locale: 'id',
                                                                  symbol: 'Rp ',
                                                                  decimalDigits:
                                                                      0)
                                                              .format((ticket
                                                                          .seats!
                                                                          .length *
                                                                      30000) +
                                                                  (ticket.seats!
                                                                          .length *
                                                                      1500))),
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height: 120,
                                            child: Image.asset(
                                                "assets/images/qr_code.png")),
                                      ],
                                    ),
                                  )
                                ])),
                        Positioned(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: const MySeparator(color: Colors.grey)),
                        ),
                        Positioned(
                            left: -25,
                            top: MediaQuery.of(context).size.height - 500,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                  color: kBackgroundColor,
                                  shape: BoxShape.circle),
                            )),
                        Positioned(
                            right: -25,
                            top: MediaQuery.of(context).size.height - 500,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                  color: kBackgroundColor,
                                  shape: BoxShape.circle),
                            )),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(),);
                }
              });
        },
      ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 160,
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: const TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                secondTitle,
                style: const TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  secondDesc,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
