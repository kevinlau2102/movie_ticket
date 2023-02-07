import 'package:flutter/material.dart';
import 'package:movie_app/entities/cast.dart';

class CastWidget extends StatelessWidget {
  final Cast cast;
  const CastWidget({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              "https://image.tmdb.org/t/p/w500/${cast.profile_path}",fit: BoxFit.cover,height: 100,width: 100,
              
              errorBuilder: (context, error, stackTrace) {
            return Image.asset("assets/images/placeholder.png");
          },
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(cast.name, style: const TextStyle(color: Colors.white, fontSize: 15),)),
          Container(
            alignment: Alignment.topLeft,
            child: Text(cast.character, style: const TextStyle(color: Colors.grey, fontSize: 12),))
        ],
      ),
    );
  }
}
