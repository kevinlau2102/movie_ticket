import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/active_ticket_page.dart';
import 'package:movie_app/screens/history_ticket_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 34, 34, 37),
              title: const Text(
                      "My Tickets",
                      style: kBodyText2,
                    ),
                bottom: const TabBar(
                  indicatorColor: Colors.white,
              tabs: [
                Tab(
                  text: 'Active Ticket',
                ),
                Tab(text: 'History Ticket')
              ],
            )),
            body: TabBarView(
                children: [ActiveTicketPage(), HistoryTicketPage()])));
  }
}
