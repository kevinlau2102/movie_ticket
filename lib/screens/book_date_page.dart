import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/entities/ticket.dart';
import 'package:movie_app/screens/book_seat_page.dart';

import '../bloc/ticket_bloc.dart';

class BookDatePage extends StatefulWidget {
  const BookDatePage({super.key});

  @override
  State<BookDatePage> createState() => _BookDatePageState();
}

class _BookDatePageState extends State<BookDatePage> {
  late List<DateTime> days = List.generate(
    8,
    (index) => (index == 0)
        ? DateTime.now()
        : DateTime.now().add(
            Duration(days: index),
          ),
  );

  final formatter = DateFormat('E');
  final formatTime = DateFormat('Hm');

  final formatDate = DateFormat('yMd');

  late DateTime now = DateTime.now();

  late List<DateTime> timeSlots = List.generate(
      7,
      (index) =>
          DateTime(now.year, now.month, now.day, 10 + (index * 2), 0, 0));

  String _selectedDate =
      "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : "${DateTime.now().month}"}-${DateTime.now().day < 10 ? "0${DateTime.now().day}" : "${DateTime.now().day}"}";

  String _selectedTime = "";

  String _selectedPlace = "";

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
        title: const Text("Select date & time"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        var month = days[index].month < 10
                            ? "0${days[index].month}"
                            : "${days[index].month}";
                        var date = days[index].day < 10
                            ? "0${days[index].day}"
                            : "${days[index].day}";
                        _selectedDate = "${days[index].year}-$month-$date";
                        _selectedTime = "";

                      });
                    },
                    child: Container(
                      margin:
                          EdgeInsets.fromLTRB(index == 0 ? 20 : 0, 0, 20, 0),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: _selectedDate ==
                                      "${days[index].year}-${days[index].month}-${days[index].day}" ||
                                      _selectedDate ==
                                      "${days[index].year}-0${days[index].month}-${days[index].day}" ||
                                  _selectedDate ==
                                      "${days[index].year}-0${days[index].month}-0${days[index].day}"
                              ? Colors.amber.shade600
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Text(days[index].day.toString(),
                              style: TextStyle(
                                  fontSize: 30,
                                  color: _selectedDate ==
                                              "${days[index].year}-${days[index].month}-${days[index].day}" ||
                                              _selectedDate ==
                                      "${days[index].year}-0${days[index].month}-${days[index].day}" ||
                                          _selectedDate ==
                                              "${days[index].year}-0${days[index].month}-0${days[index].day}"
                                      ? kBackgroundColor
                                      : Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            formatter.format(days[index]),
                            style: TextStyle(
                                fontSize: 15,
                                color: _selectedDate ==
                                            "${days[index].year}-${days[index].month}-${days[index].day}" ||
                                            _selectedDate ==
                                      "${days[index].year}-0${days[index].month}-${days[index].day}" ||
                                        _selectedDate ==
                                            "${days[index].year}-0${days[index].month}-0${days[index].day}"
                                    ? kBackgroundColor
                                    : Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  height: 10,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "CGV 23 Paskal Hyper Square",
                              style: kHeadline4,
                            ),
                            const Text(
                              "Bandung",
                              style: kBodyText,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "2D",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Rp 30.000",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 10,
                              runSpacing: 15,
                              children:
                                  List.generate(timeSlots.length, (index) {
                                return GestureDetector(
                                  onTap: DateTime.parse(_selectedDate)
                                              .isBefore(DateTime.now()) &&
                                          timeSlots[index]
                                              .isBefore(DateTime.now())
                                      ? null
                                      : () {
                                          setState(() {
                                            _selectedPlace =
                                                "CGV 23 Paskal Hyper Square";
                                            _selectedTime = formatTime
                                                .format(timeSlots[index]);
                                          });
                                        },
                                  child: Container(
                                    height: 35,
                                    alignment: Alignment.center,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: DateTime.parse(_selectedDate)
                                                    .isBefore(DateTime.now()) &&
                                                timeSlots[index]
                                                    .isBefore(DateTime.now())
                                            ? Colors.grey.shade600
                                            : (_selectedPlace ==
                                                        "CGV 23 Paskal Hyper Square" &&
                                                    _selectedTime ==
                                                        formatTime.format(
                                                            timeSlots[index])
                                                ? Colors.amber.shade600
                                                : const Color(0xFF1B191C)),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      formatTime.format(timeSlots[index]),
                                      style: TextStyle(
                                          color: _selectedPlace ==
                                                      "CGV 23 Paskal Hyper Square" &&
                                                  _selectedTime ==
                                                      formatTime.format(
                                                          timeSlots[index])
                                              ? kBackgroundColor
                                              : Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              "CGV Paris Van Java",
                              style: kHeadline4,
                            ),
                            const Text(
                              "Bandung",
                              style: kBodyText,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "2D",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Rp 30.000",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 10,
                              runSpacing: 15,
                              children:
                                  List.generate(timeSlots.length, (index) {
                                return GestureDetector(
                                  onTap: DateTime.parse(_selectedDate)
                                              .isBefore(DateTime.now()) &&
                                          timeSlots[index]
                                              .isBefore(DateTime.now())
                                      ? null
                                      : () {
                                          setState(() {
                                            _selectedPlace =
                                                "CGV Paris Van Java";
                                            _selectedTime = formatTime
                                                .format(timeSlots[index]);
                                          });
                                        },
                                  child: Container(
                                    height: 35,
                                    alignment: Alignment.center,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: DateTime.parse(_selectedDate)
                                                    .isBefore(DateTime.now()) &&
                                                timeSlots[index]
                                                    .isBefore(DateTime.now())
                                            ? Colors.grey.shade600
                                            : (_selectedPlace ==
                                                        "CGV Paris Van Java" &&
                                                    _selectedTime ==
                                                        formatTime.format(
                                                            timeSlots[index])
                                                ? Colors.amber.shade600
                                                : const Color(0xFF1B191C)),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      formatTime.format(timeSlots[index]),
                                      style: TextStyle(
                                          color: _selectedPlace ==
                                                      "CGV Paris Van Java" &&
                                                  _selectedTime ==
                                                      formatTime.format(
                                                          timeSlots[index])
                                              ? kBackgroundColor
                                              : Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              "XXI Cihampelas Walk",
                              style: kHeadline4,
                            ),
                            const Text(
                              "Bandung",
                              style: kBodyText,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "2D",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Rp 30.000",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 10,
                              runSpacing: 15,
                              children:
                                  List.generate(timeSlots.length, (index) {
                                return GestureDetector(
                                  onTap: DateTime.parse(_selectedDate)
                                              .isBefore(DateTime.now()) &&
                                          timeSlots[index]
                                              .isBefore(DateTime.now())
                                      ? null
                                      : () {
                                          setState(() {
                                            _selectedPlace =
                                                "XXI Cihampelas Walk";
                                            _selectedTime = formatTime
                                                .format(timeSlots[index]);
                                          });
                                        },
                                  child: Container(
                                    height: 35,
                                    alignment: Alignment.center,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: DateTime.parse(_selectedDate)
                                                    .isBefore(DateTime.now()) &&
                                                timeSlots[index]
                                                    .isBefore(DateTime.now())
                                            ? Colors.grey.shade600
                                            : (_selectedPlace ==
                                                        "XXI Cihampelas Walk" &&
                                                    _selectedTime ==
                                                        formatTime.format(
                                                            timeSlots[index])
                                                ? Colors.amber.shade600
                                                : const Color(0xFF1B191C)),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      formatTime.format(timeSlots[index]),
                                      style: TextStyle(
                                          color: _selectedPlace ==
                                                      "XXI Cihampelas Walk" &&
                                                  _selectedTime ==
                                                      formatTime.format(
                                                          timeSlots[index])
                                              ? kBackgroundColor
                                              : Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              "XXI Bandung Trade Center",
                              style: kHeadline4,
                            ),
                            const Text(
                              "Bandung",
                              style: kBodyText,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "2D",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Rp 30.000",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 10,
                              runSpacing: 15,
                              children:
                                  List.generate(timeSlots.length, (index) {
                                return GestureDetector(
                                  onTap: DateTime.parse(_selectedDate)
                                              .isBefore(DateTime.now()) &&
                                          timeSlots[index]
                                              .isBefore(DateTime.now())
                                      ? null
                                      : () {
                                          setState(() {
                                            _selectedPlace =
                                                "XXI Bandung Trade Center";
                                            _selectedTime = formatTime
                                                .format(timeSlots[index]);
                                          });
                                        },
                                  child: Container(
                                    height: 35,
                                    alignment: Alignment.center,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: DateTime.parse(_selectedDate)
                                                    .isBefore(DateTime.now()) &&
                                                timeSlots[index]
                                                    .isBefore(DateTime.now())
                                            ? Colors.grey.shade600
                                            : (_selectedPlace ==
                                                        "XXI Bandung Trade Center" &&
                                                    _selectedTime ==
                                                        formatTime.format(
                                                            timeSlots[index])
                                                ? Colors.amber.shade600
                                                : const Color(0xFF1B191C)),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      formatTime.format(timeSlots[index]),
                                      style: TextStyle(
                                          color: _selectedPlace ==
                                                      "XXI Bandung Trade Center" &&
                                                  _selectedTime ==
                                                      formatTime.format(
                                                          timeSlots[index])
                                              ? kBackgroundColor
                                              : Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: GestureDetector(
                  onTap: _selectedDate == "" || _selectedTime == ""
                      ? null
                      : () {
                          context.read<TicketBloc>().add(TicketEvent.started(
                                Ticket(
                                    date: Timestamp.fromDate(DateTime.parse(
                                        "$_selectedDate $_selectedTime")),
                                    location: _selectedPlace),
                              ));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BookSeatPage(),
                            ),
                          );
                        },
                  child: _selectedDate == "" || _selectedTime == ""
                      ? Container(
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text(
                            "Please select date and time first",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          color: Colors.red.shade600,
                          child: const Text(
                            "Next",
                            style: kBodyText4,
                          ),
                        ))),
        ],
      ),
    );
  }
}
