import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/screen.dart';
import 'package:movie_app/services/auth_services.dart';
import '../widgets/widget.dart';
import '../constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisibility = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users;

  @override
  void initState() {
    super.initState();
    users = firestore.collection('users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
         SizedBox(height: MediaQuery.of(context).size.height / 8),
          const Center(
            child: Icon(
              Icons.movie_rounded,
              size: 100,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 30,
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
                      "Create your account",
                      style: kBodyText2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      hintText: 'Full Name',
                      inputType: TextInputType.text,
                      textController: nameController,
                    ),
                    MyTextField(
                      hintText: 'Email',
                      inputType: TextInputType.text,
                      textController: emailController,
                    ),
                    MyPasswordField(
                      isPasswordVisible: passwordVisibility,
                      onTap: () {
                        setState(() {
                          passwordVisibility = !passwordVisibility;
                        });
                      },
                      passwordController: passwordController,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextButton(
                  buttonName: 'Create Account',
                  onTap: () async {
                    if (nameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      showWarning(
                          context, "Please enter all the required fields");
                    } else {
                      showProgress(context);
                      User? user = await AuthServices.signUp(
                          emailController.text, passwordController.text);
                      users.doc(user?.uid).set({
                        'name': nameController.text,
                        'email': emailController.text,
                        'balance': 50000,
                      }).then((value) {
                        Navigator.of(context).pop();
                        showSuccess(context);
                      });
                    }
                  },
                  bgColor: Colors.white,
                  textColor: Colors.black87,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: kBodyText,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: kBodyText.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showSuccess(BuildContext context) {
    AwesomeDialog(
      titleTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      descTextStyle: const TextStyle(color: Colors.white),
      title: 'Register successful',
      dialogBackgroundColor: kBackgroundColor,
      width: MediaQuery.of(context).size.width,
      desc: "Please login again.",
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      onDismissCallback: (_) {
        Timer(const Duration(milliseconds: 300), () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const SignInPage(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
        });
      },
      btnOkOnPress: () {},
      btnOkText: "Return to login",
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

  void showWarning(BuildContext context, String message) {
    AwesomeDialog(
      dialogBackgroundColor: kBackgroundColor,
      titleTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      descTextStyle: const TextStyle(color: Colors.white),
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Unable to register',
      desc: message,
      onDismissCallback: (type) {
        // Navigator.of(context).popUntil((route) => route.isFirst);
      },
      btnOkOnPress: () {},
      btnOkText: "OK",
    ).show();
  }
}
