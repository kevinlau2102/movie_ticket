import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/entities/transaction.dart' as Transaction2;
import 'package:movie_app/entities/user.dart' as User2;
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/top_up_page.dart';
import 'package:movie_app/widgets/transaction_history_widget.dart';

class EWalletPage extends StatelessWidget {
  EWalletPage({super.key});

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users = firestore.collection('users');
  late CollectionReference transactions = firestore.collection('transaction');

  final userId = FirebaseAuth.instance.currentUser?.uid;
  late Query queryTransaction = transactions.where('user_id', isEqualTo: userId).orderBy('date', descending: true);

  late User2.User user;

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
        title: const Text("E-Wallet"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.blue.shade600),
                child: Stack(
                  children: [
                    Positioned(
                      left: -250,
                      right: 0,
                      bottom: 50,
                      top: -100,
                      child: Container(
                          decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white12,
                      )),
                    ),
                    Positioned(
                      left: 0,
                      right: -300,
                      bottom: -100,
                      top: 100,
                      child: Container(
                          decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white10,
                      )),
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: users.doc(userId).snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            user = User2.User.fromJson(
                                snapshot.data!.data() as Map<String, dynamic>);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "E-Wallet",
                                    style: GoogleFonts.robotoSlab(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Balance",
                                    style: kBodyText3,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        width: 200,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: 'Rp ',
                                                    decimalDigits: 0)
                                                .format(user.balance!),
                                            style: kBodyText2,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EWalletPage(),
                                            ),
                                          ),
                                          child: Container(
                                            color: Colors.transparent,
                                            alignment: Alignment.centerRight,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue.shade900),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const TopUpPage(),
                                                    ),
                                                  );
                                                },
                                                child: const Text("Top Up")),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Card Holder",
                                              style: kBodyText6,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    top: 2),
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        Colors.blue.shade800),
                                                child: const Icon(
                                                  Icons.check_rounded,
                                                  size: 10,
                                                  color: Colors.white,
                                                ))
                                          ],
                                        ),
                                        Text(
                                          user.name.toString(),
                                          style: kBodyText4,
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Transaction History",
                style: kHeadline4,
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: queryTransaction.snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.size == 0) {
                      return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.money_off,
                      size: 80,
                      color: Colors.grey,
                    ),
                    Text(
                      "No transaction history",
                      style: kBodyText4,
                    ),
                    Text(
                      "You haven't made any transactions.",
                      style: kBodyText,
                    )
                  ],
                ));
                    } else {
                      return ListView(
                    children: snapshot.data!.docs.map((e) {
                      Transaction2.Transaction transaction =
                          Transaction2.Transaction.fromJson(e.data() as Map<String, dynamic>);
                      
                      if (transaction.user_id == userId) {
                        return TransactionHistoryWidget(transaction: transaction);
                      } else {
                        return const SizedBox();
                      }
                    }).toList(),
                  );
                    }
                    
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
