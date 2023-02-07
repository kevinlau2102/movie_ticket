import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/temp.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> signInAnonymous() async {
    try {
      final User? user = (await _auth.signInAnonymously()).user;
      return user;
    } on FirebaseAuthException catch (e) {
      message = e.message.toString();
      return null;
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();
  }

  static Future<User?> signUp(String email, String password) async {
    try {
      final User? user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
      return user;
    } on FirebaseAuthException catch (e) {
      message = e.message.toString();
      return null;
    }
  }

    static Future<User?> signIn(String email, String password) async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      return user;
    } on FirebaseAuthException catch (e) {
      message = e.message.toString();
      return null;
    }
  }

  static Stream<User?> get userStream => _auth.authStateChanges();
}


