import 'package:flutter/material.dart';
import 'package:movie_app/entities/genre.dart';

class GenreWidget extends StatelessWidget {
  final Genre genre;
  const GenreWidget({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white)),
      child: Center(
          child: Text(
        genre.name,
        style: const TextStyle(color: Colors.white),
      )),
    );
  }
}
