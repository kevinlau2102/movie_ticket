import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_services.dart';
import 'package:movie_app/widgets/now_playing_movie_widget.dart';

class ListMoviePage extends StatelessWidget {
  const ListMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: const Text("Now Playing"),
        ),
      body: FutureBuilder(
          future: MovieServices.getListMovie(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView( children: (snapshot.data ?? [])
                      .map((e) => NowPlayingMovieWidget(movie: e))
                      .toList(),);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
