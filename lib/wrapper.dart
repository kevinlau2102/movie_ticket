import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/pages.dart';
import 'package:movie_app/screens/screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    return (user?.uid == null) ? const SignInPage() : Pages();
  }
}