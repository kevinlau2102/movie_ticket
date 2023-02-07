import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/entities/movie.dart';
import 'package:movie_app/screens/movie_details_page.dart';

class CarouselWidget extends StatelessWidget {
  final Movie movie;
  const CarouselWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final double rating = movie.vote_average ?? 0;
    return GestureDetector(
      onTap: () {
        context.read<MovieBloc>().add(MovieEvent.started(movie.id ?? 0));
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => MovieDetailsPage()));
      },
      child: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)
                      .createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        "http://image.tmdb.org/t/p/w500/${movie.backdrop_path}",
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Positioned(
                  bottom: 10,
                  left: 10,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 + 60,
                          child: Text(
                            movie.title != null ? movie.title ?? "" : movie.name ?? "",
                            style: kHeadline2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            RatingBar(
                              initialRating: rating.round().toDouble() / 2,
                              minRating: 1,
                              itemSize: 20,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              onRatingUpdate: (_) {},
                              ratingWidget: RatingWidget(
                                  full: const Icon(Icons.star_rounded,
                                      color: Colors.amber),
                                  half: ShaderMask(
                                    blendMode: BlendMode.srcATop,
                                    shaderCallback: (Rect rect) {
                                      return LinearGradient(
                                        stops: const [0, 0.5, 0.5],
                                        colors: [
                                        Colors.amber,
                                        Colors.amber,
                                        Colors.amber.withOpacity(0)
                                      ]).createShader(rect);
                                    },
                                    child: Icon(Icons.star_rounded, color: Colors.grey.shade600,),
                                  ),
                                  empty: Icon(Icons.star_rounded,
                                      color: Colors.grey.shade600)),
                            ),
                            const SizedBox(width: 5,),
                            Text(
                              "${movie.vote_average?.toStringAsFixed(1)}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}
