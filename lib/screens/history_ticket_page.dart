import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/entities/ticket.dart';
import 'package:movie_app/widgets/history_widget.dart';

class HistoryTicketPage extends StatelessWidget {
  HistoryTicketPage({super.key});

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference tickets = firestore.collection('tickets');
  late Query query = tickets
      .where('date', isLessThanOrEqualTo: DateTime.now())
      .orderBy("date", descending: true);
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
          stream: query.snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.size == 0) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.movie_filter_rounded,
                      size: 80,
                      color: Colors.grey,
                    ),
                    Text(
                      "No history tickets",
                      style: kBodyText4,
                    ),
                    Text(
                      "Get your movie tickets easily!",
                      style: kBodyText,
                    )
                  ],
                ));
              } else {
                return ListView(
                  children: snapshot.data!.docs.map((e) {
                    Ticket ticket =
                        Ticket.fromJson(e.data() as Map<String, dynamic>);
                    var date = DateTime.fromMicrosecondsSinceEpoch(
                        ticket.date!.microsecondsSinceEpoch);
                    if (ticket.user_id == userId &&
                        date.isBefore(DateTime.now())) {
                      return HistoryWidget(ticket: ticket);
                    } else {
                      return const SizedBox();
                    }
                  }).toList(),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
