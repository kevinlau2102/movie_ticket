import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/e-wallet_page.dart';
import 'package:movie_app/screens/edit_profile_page.dart';
import 'package:movie_app/screens/screen.dart';
import 'package:movie_app/screens/top_up_page.dart';
import 'package:movie_app/services/auth_services.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users = firestore.collection('users');
  final userId = FirebaseAuth.instance.currentUser?.uid;

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
          title: const Text("My Profile"),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: users.doc(userId).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Container(
                              height: 100,
                              width: 100.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/images/placeholder.png')))),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data!['name'],
                            style: kBodyText4,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data!['email'],
                            style: kBodyText5,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EWalletPage(),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.wallet,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "E-Wallet",
                                            style: kBodyText3,
                                          ),
                                          Text(
                                            NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: 'Rp ',
                                                    decimalDigits: 0)
                                                .format(
                                                    snapshot.data!['balance']),
                                            style: kBodyText,
                                          )
                                        ],
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
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfilePage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          "Edit Profile",
                                          style: kBodyText3,
                                        ),
                                        Expanded(
                                            child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const EditProfilePage(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            alignment: Alignment.centerRight,
                                            child: const Icon(
                                              Icons
                                                  .keyboard_arrow_right_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.white12,
                                  height: 1,
                                ),
                                GestureDetector(
                                  onTap: () => showLogout(
                                      context, "Are you sure want to log out?"),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    height: 60,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.logout_rounded,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          "Log out",
                                          style: kBodyText3,
                                        ),
                                        Expanded(
                                            child: GestureDetector(
                                          onTap: () => showLogout(context,
                                              "Are you sure want to log out?"),
                                          child: Container(
                                            color: Colors.transparent,
                                            alignment: Alignment.centerRight,
                                            child: const Icon(
                                              Icons
                                                  .keyboard_arrow_right_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.white12,
                                  height: 1,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              }
            }));
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

  void showLogout(BuildContext context, String message) {
    AwesomeDialog(
            dialogBackgroundColor: kBackgroundColor,
            titleTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            descTextStyle: const TextStyle(color: Colors.white),
            context: context,
            dialogType: DialogType.noHeader,
            animType: AnimType.bottomSlide,
            title: 'Log out confirmation',
            desc: message,
            btnCancelOnPress: () {},
            btnCancelText: "Cancel",
            btnCancelColor: Colors.black26,
            btnOkOnPress: () async {
              showProgress(context);
              if (FirebaseAuth.instance.currentUser != null) {
                await AuthServices.signOut().then((value) {
                  Navigator.of(context).pop();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (_) => const SignInPage()));
                });
              }
            },
            btnOkText: "Log out",
            btnOkColor: Colors.red.shade600)
        .show();
  }
}
