import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/entities/ticket.dart';
import 'package:movie_app/widgets/history_widget.dart';

class ActiveTicketPage extends StatelessWidget {
  ActiveTicketPage({super.key});

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference tickets = firestore.collection('tickets');

  final userId = FirebaseAuth.instance.currentUser?.uid;
  late Query query = tickets
      .where('date', isGreaterThanOrEqualTo: DateTime.now()).where("user_id", isEqualTo: userId)
      .orderBy("date");
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
                          "No active tickets",
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
                      padding: const EdgeInsets.only(bottom: 10),
                      children: snapshot.data!.docs.map((e) {
                        Ticket ticket =
                            Ticket.fromJson(e.data() as Map<String, dynamic>);
                        var date = DateTime.fromMicrosecondsSinceEpoch(
                            ticket.date!.microsecondsSinceEpoch);
                        if (ticket.user_id == userId &&
                            date.isAfter(DateTime.now())) {
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
