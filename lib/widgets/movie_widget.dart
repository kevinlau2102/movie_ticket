import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/screens/movie_details_page.dart';

import '../entities/movie.dart';

class MovieWidget extends StatelessWidget {
  final Movie movie;

  const MovieWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double? rating = movie.vote_average;
    return GestureDetector(
      onTap: () {
        context.read<MovieBloc>().add(MovieEvent.started(movie.id ?? 0));
        Navigator.of(context, rootNavigator: true)
            .push(MaterialPageRoute(builder: (_) => MovieDetailsPage()));
      },
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width / 2 - 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                "http://image.tmdb.org/t/p/w300/${movie.poster_path}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2 - 70,
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5,),
                Text(
                  movie.title ?? "",
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: RatingBar(
                        initialRating:
                            rating != null ? rating.round().toDouble() / 2 : 0,
                        minRating: 1,
                        itemSize: 15,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        onRatingUpdate: (_) {},
                        ratingWidget: RatingWidget(
                            full: const Icon(Icons.star_rounded,
                                color: Colors.amber),
                            half: ShaderMask(
                              blendMode: BlendMode.srcATop,
                              shaderCallback: (Rect rect) {
                                return LinearGradient(stops: const [
                                  0,
                                  0.5,
                                  0.5
                                ], colors: [
                                  Colors.amber,
                                  Colors.amber,
                                  Colors.amber.withOpacity(0)
                                ]).createShader(rect);
                              },
                              child: Icon(
                                Icons.star_rounded,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            empty: Icon(Icons.star_rounded,
                                color: Colors.grey.shade600)),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      "$rating",
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
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
}
