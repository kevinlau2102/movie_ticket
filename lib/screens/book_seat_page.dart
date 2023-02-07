import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/bloc/ticket_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/entities/ticket.dart';
import 'package:movie_app/screens/book_confirm_page.dart';
import 'package:movie_app/services/movie_services.dart';

class BookSeatPage extends StatefulWidget {
  const BookSeatPage({super.key});

  @override
  State<BookSeatPage> createState() => _BookSeatPageState();
}

class _BookSeatPageState extends State<BookSeatPage> {
  final List<String> _selectedSeat = [];
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
          title: const Text("Select your seat"),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                BlocBuilder<TicketBloc, TicketState>(
                  builder: (context, state) {
                    return Container(
                      padding:
                          const EdgeInsets.only(left: 25, top: 10, right: 30),
                      width: MediaQuery.of(context).size.width,
                      child: BlocBuilder<MovieBloc, MovieState>(
                        builder: (context, stateMovie) {
                          return FutureBuilder(
                            future: MovieServices.getMovie(stateMovie.when(
                                initial: () => "0", running: (id) => '$id')),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data?.title ?? "",
                                          style: kBodyText4,
                                        ),
                                        Text(state.when(
                                            initial: () => "",
                                            running: (ticket) =>
                                                ticket.location.toString()), style: kBodyText5,),
                                        Text(
                                          state.when(
                                            initial: () => "",
                                            running: (ticket) =>
                                                "${formatDate.format(ticket.date!.toDate())} | ${formatTime.format(ticket.date!.toDate())}",
                                          ),
                                          style: kBodyText5,
                                        )
                                      ],
                                    ),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          "http://image.tmdb.org/t/p/w500/${snapshot.data?.poster_path}",
                                          fit: BoxFit.fitWidth,
                                          width: 50,
                                        )),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 100,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 80,
                        child: CustomPaint(
                          painter: CurvePainter(),
                          child: Container(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Center(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Cinema Screen",
                              style: kBodyText,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: Column(
                      children: List.generate(
                          10,
                          ((col) => Row(children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Wrap(
                                    children: List.generate(
                                        8,
                                        (row) => "${String.fromCharCode(col + 65)}${row + 1}" != "A8" &&
                                                "${String.fromCharCode(col + 65)}${row + 1}" !=
                                                    "B8" &&
                                                "${String.fromCharCode(col + 65)}${row + 1}" !=
                                                    "C8" &&
                                                "${String.fromCharCode(col + 65)}${row + 1}" !=
                                                    "D8"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (_selectedSeat.contains(
                                                        "${String.fromCharCode(col + 65)}${row + 1}")) {
                                                      _selectedSeat.removeWhere(
                                                          (element) =>
                                                              element ==
                                                              "${String.fromCharCode(col + 65)}${row + 1}");
                                                    } else if (_selectedSeat
                                                            .length >
                                                        7) {
                                                      showNotification(
                                                          context,
                                                          "Maximum seats amount.",
                                                          "You can only pick 8 seats per transaction");
                                                      return;
                                                    } else {
                                                      _selectedSeat.add(
                                                          "${String.fromCharCode(col + 65)}${row + 1}");
                                                    }
                                                    _selectedSeat.sort();
                                                  });
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 7,
                                                      vertical: 5),
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                      color: _selectedSeat.contains(
                                                              "${String.fromCharCode(col + 65)}${row + 1}")
                                                          ? Colors
                                                              .amber.shade600
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    "${String.fromCharCode(col + 65)}${row + 1}",
                                                    style:
                                                        const TextStyle(fontSize: 10),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 7),
                                                height: 20,
                                                width: 20,
                                              ))),
                              ])))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Available",
                      style: kBodyText,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade600,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Reserved",
                      style: kBodyText,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade600,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Selected",
                      style: kBodyText,
                    )
                  ]),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    height: 10,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              _selectedSeat.isEmpty
                                  ? "Your seat"
                                  : "Your seat (${_selectedSeat.length})",
                              style: kTitleText,
                            ),
                          ),
                          _selectedSeat.isNotEmpty
                              ? GestureDetector(
                                  onTap: () => setState(() {
                                    _selectedSeat.clear();
                                  }),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Clear all",
                                      style: TextStyle(
                                          color: Colors.red.shade600,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                          children: List.generate(
                        _selectedSeat.length,
                        (index) => _selectedSeat.isNotEmpty
                            ? Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(right: 10),
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  _selectedSeat[index],
                                  style: const TextStyle(fontSize: 12),
                                ),
                              )
                            : const SizedBox(
                                height: 25,
                                width: 25,
                              ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Total",
                          style: kTitleText,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _selectedSeat.isEmpty
                              ? ''
                              : NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp ',
                                      decimalDigits: 0)
                                  .format(
                                  _selectedSeat.length * 30000,
                                ),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<TicketBloc, TicketState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: _selectedSeat.isEmpty
                            ? () {
                                showNotification(context, "Seat empty",
                                    "Please select the seat first");
                              }
                            : () {
                                context.read<TicketBloc>().add(
                                    TicketEvent.started(state.when(
                                        initial: () => Ticket(),
                                        running: (ticket) {
                                          ticket.seats = _selectedSeat;
                                          return ticket;
                                        })));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookConfirmPage(),
                                  ),
                                );
                              },
                        child: _selectedSeat.isEmpty
                            ? Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade700),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Next",
                                  style: kBodyText4,
                                ),
                              )
                            : Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red.shade600),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Next",
                                  style: kBodyText4,
                                ),
                              ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }

  void showNotification(BuildContext context, String title, String message) {
    AwesomeDialog(
      dialogBackgroundColor: kBackgroundColor,
      titleTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      descTextStyle: const TextStyle(color: Colors.white),
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: title,
      desc: message,
      btnOkOnPress: () {},
      btnOkText: "OK",
    ).show();
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    var startPoint = Offset(size.width * 0.15, size.height - 20);
    var controlPoint = Offset(size.width * 0.5, size.height - 60);
    var endPoint = Offset(size.width * 0.85, size.height - 20);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    canvas.drawShadow(path, const Color(0xFFFFFFFF), 10, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
