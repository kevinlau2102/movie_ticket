import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference users = _firestore.collection('users');

  static void addUser(String name, String email, String password) {
    users.add({
      'name': name,
      'email': email,
      'password': password
    });
    return;
  }


}