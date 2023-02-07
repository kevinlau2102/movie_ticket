import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/entities/transaction.dart';
import 'package:movie_app/services/movie_services.dart';

class TransactionHistoryWidget extends StatelessWidget {
  final Transaction transaction;
  const TransactionHistoryWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white12, width: 1))),
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          height: 100,
          child: isNumeric(transaction.name.toString())
              ? FutureBuilder(
                  future: MovieServices.getMovie(transaction.name.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "http://image.tmdb.org/t/p/w500/${snapshot.data?.poster_path}",
                                fit: BoxFit.cover,
                                width: 60,
                              )),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 15,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 170,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          "${DateFormat('EEE, d MMMM y').format(transaction.date?.toDate() ?? DateTime.now())}, ${DateFormat('Hm').format(transaction.date?.toDate() ?? DateTime.now())}",
                                          style: kBodyText5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  transaction.type == "receive"
                                      ? Text(
                                          NumberFormat.currency(
                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(transaction.amount),
                                          style: TextStyle(
                                              color: Colors.green.shade600,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          NumberFormat.currency(
                            locale: 'id', symbol: '-Rp ', decimalDigits: 0)
                        .format(transaction.amount),
                                          style: TextStyle(
                                              color: Colors.red.shade600,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
              : Row(
                  children: [
                    Container(
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.shade700),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.attach_money,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                transaction.name.toString(),
                                style: kBodyText4,
                              ),
                              Text(
                                              "${DateFormat('EEE, d MMMM y').format(transaction.date?.toDate() ?? DateTime.now())}, ${DateFormat('Hm').format(transaction.date?.toDate() ?? DateTime.now())}",
                                              style: kBodyText5,
                                            ),
                            ],
                          ),
                          transaction.type == "receive"
                                      ? Container(
                                        alignment: Alignment.centerRight,
                                        width: 100,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                              NumberFormat.currency(
                                                                    locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                                                .format(transaction.amount),
                                              style: TextStyle(
                                                  color: Colors.green.shade600,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                        ),
                                      )
                                      : Container(
                                        alignment: Alignment.centerRight,
                                        width: 100,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                              NumberFormat.currency(
                                                                    locale: 'id', symbol: '-Rp ', decimalDigits: 0)
                                                                .format(transaction.amount),
                                              style: TextStyle(
                                                  color: Colors.red.shade600,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                        ),
                                      )
                        ],
                      ),
                    )
                  ],
                ),
        ));
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }
}
