import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/bloc/ticket_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/entities/ticket.dart';
import 'package:movie_app/screens/history_ticket_details_page.dart';
import 'package:movie_app/services/movie_services.dart';

class HistoryWidget extends StatelessWidget {
  final Ticket ticket;
  const HistoryWidget({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.read<TicketBloc>().add(TicketEvent.started(ticket));
          Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => HistoryTicketDetailsPage()));
        },
        child: Container(
          padding: const EdgeInsets.only(left: 20, top: 10),
          height: 150,
          child: FutureBuilder(
              future: MovieServices.getMovie(ticket.movie_id.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "http://image.tmdb.org/t/p/w500/${snapshot.data?.poster_path}",
                          )),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${snapshot.data?.title}",
                                style: kBodyText4,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                              Text(
                                "${DateFormat('EEE, MMM d, y').format(ticket.date?.toDate() ?? DateTime.now())}, ${DateFormat('Hm').format(ticket.date?.toDate() ?? DateTime.now())}",
                                style: kBodyText,
                              ),
                              Text(
                                ticket.location.toString(),
                                style: kBodyText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox(
                    width: 100,
                  );
                }
              }),
        ));
  }
}
