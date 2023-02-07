import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  String? user_id;
  String? movie_id;
  Timestamp? date;
  String? location;
  int? price_per_seat;
  List<String>? seats;
  String? order_id;

  Ticket(
      {this.user_id,
      this.movie_id,
      this.date,
      this.location,
      this.price_per_seat,
      this.seats,
      this.order_id});

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        date: json['date'],
        user_id: json['user_id'],
        movie_id: json['movie_id'],
        location: json['location'],
        price_per_seat: json['price_per_seat'],
        seats: List<String>.from(json['seats']),
        order_id: json['order_id']
      );
}
