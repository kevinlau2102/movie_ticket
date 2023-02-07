import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/book_date_page.dart';
import 'package:movie_app/services/movie_services.dart';
import 'package:movie_app/widgets/cast_widget.dart';
import 'package:movie_app/widgets/genre_widget.dart';

class MovieDetailsPage extends StatelessWidget {
  MovieDetailsPage({super.key});

  late double rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(shape: BoxShape.circle, color: kBackgroundColor),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: GestureDetector(
                  onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BookDatePage(),
                            ),
                          );
                        },
                  child:Container(
                          alignment: Alignment.center,
                          color: Colors.red.shade600,
                          child: const Text(
                            "Buy Ticket",
                            style: kBodyText4,
                          ),
                        ))),
          Container(
            margin: const EdgeInsets.only(bottom: 45),
            child: ListView(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top),
                children: [
                  BlocBuilder<MovieBloc, MovieState>(
                    builder: (context, state) {
                      return FutureBuilder(
                          future: MovieServices.getMovie(
                              state.when(initial: () => "0", running: (id) => '$id')),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              rating = snapshot.data?.vote_average ?? 0;
                              return Column(
                                children: [
                                  ShaderMask(
                                    shaderCallback: (rect) {
                                      return const LinearGradient(
                                              colors: [
                                            Colors.black,
                                            Colors.transparent
                                          ],
                                              begin: Alignment.center,
                                              end: Alignment.bottomCenter)
                                          .createShader(Rect.fromLTRB(
                                              0, 0, rect.width, rect.height));
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: Image.network(
                                      "http://image.tmdb.org/t/p/w500/${snapshot.data?.backdrop_path}",
                                      errorBuilder: (context, error, stackTrace) =>
                                          Image.asset(
                                              "assets/images/placeholder.png"),
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${snapshot.data?.title}",
                                              textAlign: TextAlign.start,
                                              style: kHeadline2),
                                          SizedBox(
                                              height: 50,
                                              child: ListView(
                                                scrollDirection: Axis.horizontal,
                                                children: (snapshot.data?.genres
                                                        as List)
                                                    .map((e) => GenreWidget(genre: e))
                                                    .toList(),
                                              )),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  const IconTheme(
                                                      data: IconThemeData(
                                                          color: Colors.white),
                                                      child: Icon(Icons.timer)),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${snapshot.data?.runtime} minutes",
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              RatingBar(
                                                initialRating:
                                                    rating.round().toDouble() / 2,
                                                minRating: 1,
                                                itemSize: 20,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3.0),
                                                onRatingUpdate: (_) {},
                                                ratingWidget: RatingWidget(
                                                    full: const Icon(
                                                        Icons.star_rounded,
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
                                                              Colors.amber
                                                                  .withOpacity(0)
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
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top:3),
                                                child: Text(
                                                  "${snapshot.data?.vote_average?.toStringAsFixed(1)} / 10",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            "Overview",
                                            style: kTitleText,
                                          ),
                                          Text(
                                            "${snapshot.data?.overview}",
                                            style: kBodyText,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            "Cast",
                                            style: kTitleText,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                              child: FutureBuilder(
                                                  future: MovieServices.getCastMovie(
                                                      state.when(
                                                          initial: () => "0",
                                                          running: (id) => '$id')),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child:
                                                            Wrap(
                                                              spacing: 25,
                                                              children: (snapshot
                                                                          .data ??
                                                                      [])
                                                                  .map((e) =>
                                                                      CastWidget(
                                                                          cast: e))
                                                                  .toList()
                                                                  .sublist(
                                                                      0,
                                                                      snapshot.data!
                                                                                  .length >
                                                                              10
                                                                          ? 10
                                                                          : snapshot
                                                                              .data
                                                                              ?.length),
                                                            )
                                                          );
                                                    } else {
                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    }
                                                  })),
                                        ],
                                      )),
                                ],
                              );
                            } else {
                              return SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.9,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ));
                            }
                          });
                    },
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
