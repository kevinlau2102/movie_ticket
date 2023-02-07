import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/entities/movie.dart';
import 'package:movie_app/screens/movie_details_page.dart';
import 'package:movie_app/services/movie_services.dart';

class NowPlayingMovieWidget extends StatelessWidget {
  final Movie movie;
  const NowPlayingMovieWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double? rating = movie.vote_average;
    return GestureDetector(
        onTap: () {
          context.read<MovieBloc>().add(MovieEvent.started(movie.id ?? 0));
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => MovieDetailsPage()));
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(left: 20, top: 10),
          height: 150,
          child: FutureBuilder(
              future: MovieServices.getMovie(movie.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "http://image.tmdb.org/t/p/w500/${snapshot.data?.poster_path}",
                          )),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${snapshot.data?.title}",
                                style: kBodyText4,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                              FutureBuilder(
                                future:
                                    MovieServices.getMovie(movie.id.toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data?.genres
                                              .map((e) => e.name)
                                              .join(", ") ??
                                          "",
                                      style: kBodyText5,
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: RatingBar(
                                      initialRating: rating != null
                                          ? rating.round().toDouble() / 2
                                          : 0,
                                      minRating: 1,
                                      itemSize: 15,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      onRatingUpdate: (_) {},
                                      ratingWidget: RatingWidget(
                                          full: const Icon(Icons.star_rounded,
                                              color: Colors.amber),
                                          half: ShaderMask(
                                            blendMode: BlendMode.srcATop,
                                            shaderCallback: (Rect rect) {
                                              return LinearGradient(
                                                  stops: const [
                                                    0,
                                                    0.5,
                                                    0.5
                                                  ],
                                                  colors: [
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
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text("$rating", style: kBodyText5),
                                ],
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<MovieBloc>()
                                      .add(MovieEvent.started(movie.id ?? 0));
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => MovieDetailsPage()));
                                },
                                child: Container(
                                  color: Colors.transparent,
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.amber.shade600),
                                        height: 30,
                                        width: 100,
                                        child: const Text(
                                          "Details",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ))),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox(
                    width: 100,
                  );
                }
              }),
        ));
  }
}
