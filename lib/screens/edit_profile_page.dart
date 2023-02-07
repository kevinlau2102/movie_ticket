import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/widgets/my_text_button.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users = firestore.collection('users');

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
        title: const Text("Edit Profile"),
      ),
      body: FutureBuilder(
          future: users.doc(FirebaseAuth.instance.currentUser?.uid).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              emailController.text = snapshot.data!['email'];
              emailController.selection = TextSelection.fromPosition(
                TextPosition(offset: emailController.text.length),
              );

              nameController.text = snapshot.data!['name'];
              nameController.selection = TextSelection.fromPosition(
                TextPosition(offset: nameController.text.length),
              );
              return ListView(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email",
                              style: kTitleText,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                enabled: false,
                                controller: emailController,
                                style: kBodyText.copyWith(color: Colors.grey),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  contentPadding: const EdgeInsets.all(20),
                                  hintStyle: kBodyText,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              "Name",
                              style: kTitleText,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: nameController,
                                style: kBodyText.copyWith(color: Colors.white),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  contentPadding: const EdgeInsets.all(20),
                                  hintStyle: kBodyText,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                showProgress(context);
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(
                                        email: snapshot.data!['email'])
                                    .then((value) {
                                  Navigator.of(context).pop();
                                  showSuccess(context);
                                });
                              },
                              child: Text(
                                "Reset your password here",
                                style: TextStyle(color: Colors.red.shade600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        MyTextButton(
                          buttonName: 'Save Profile',
                          onTap: () async {
                            showProgress(context);
                            await users
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .update({'name': nameController.text}).then(
                                    (value) { 
                                      Navigator.of(context).pop();
                                      showEditSuccess(context);});
                          },
                          bgColor: Colors.white,
                          textColor: Colors.black87,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ))
              ]);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  void showSuccess(BuildContext context) {
    AwesomeDialog(
      titleTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      descTextStyle: const TextStyle(color: Colors.white),
      title: 'Email successfully',
      dialogBackgroundColor: kBackgroundColor,
      width: MediaQuery.of(context).size.width,
      desc: "Your reset password email has been sent.",
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      onDismissCallback: (_) {},
      btnOkOnPress: () {},
      btnOkText: "OK",
    ).show();
  }

  void showEditSuccess(BuildContext context) {
    AwesomeDialog(
      titleTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      descTextStyle: const TextStyle(color: Colors.white),
      title: 'Profile updated',
      dialogBackgroundColor: kBackgroundColor,
      width: MediaQuery.of(context).size.width,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      onDismissCallback: (_) {
        Timer(const Duration(milliseconds: 300),
            () => Navigator.of(context).pop());
      },
      btnOkOnPress: () {},
      btnOkText: "Return to profile",
    ).show();
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
}
