import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  int? amount;
  Timestamp? date;
  String? name;
  String? type;
  String? user_id;

  Transaction({this.amount, this.date, this.name, this.type, this.user_id});

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        amount: json['amount'],
        date: json['date'],
        name: json['name'],
        type: json['type'],
        user_id: json['user_id'],
      );
}
