import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/pages.dart';
import 'package:movie_app/services/auth_services.dart';
import '../constants.dart';
import '../screens/screen.dart';
import '../widgets/widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isPasswordVisible = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                      "Login to your account",
                      style: kBodyText2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      hintText: 'Phone, email or username',
                      inputType: TextInputType.text,
                      textController: emailController,
                    ),
                    MyPasswordField(
                      isPasswordVisible: isPasswordVisible,
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      passwordController: passwordController,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextButton(
                  buttonName: 'Login',
                  onTap: () async {
                    showProgress(context);
                    User? user = await AuthServices.signIn(
                        emailController.text, passwordController.text);
                    if (!mounted) return;
                    if (user?.uid == null) {
                      Navigator.of(context).pop();
                      showNotification(context, "Invalid email or password",
                          DialogType.error);
                    } else {
                      Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pages(),
                        ),
                        (route) => false
                      );
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
                      "Dont't have an account? ",
                      style: kBodyText,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Register',
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

  void showNotification(BuildContext context, String message, DialogType type) {
    AwesomeDialog(
      dialogBackgroundColor: kBackgroundColor,
      titleTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      descTextStyle: const TextStyle(color: Colors.white),
      context: context,
      dialogType: type,
      animType: AnimType.bottomSlide,
      title: 'Login failed',
      desc: message,
      btnOkOnPress: () {},
      btnOkText: "OK",
    ).show();
  }
}
