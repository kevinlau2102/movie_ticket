import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie_app/entities/cast.dart';
import 'package:movie_app/entities/movie.dart';

class MovieServices {
  static Future<Movie?> getMovie(String id) async {
    Dio dio = Dio();

    try {
      var result = await dio.get(
          'https://api.themoviedb.org/3/movie/$id?api_key=b08dd4cdf49c39367bf3f6d49e73b39d');

      Movie movie = Movie.fromJson(result.data);

      return movie;
    } on DioError catch (e) {
      log(e.response.toString());
      return null;
    }
  }

  static Future<List<Cast>?> getCastMovie(String id) async {
    Dio dio = Dio();

    try {
      var result = await dio.get(
          'https://api.themoviedb.org/3/movie/$id/credits?api_key=b08dd4cdf49c39367bf3f6d49e73b39d');

      List<Cast> casts = (result.data['cast'] as List).map((e) => Cast.fromJson(e)).toList();
    
      return casts;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<List<Movie>?> getListMovie() async {
    Dio dio = Dio();

    try {
      var result = await dio.get(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=b08dd4cdf49c39367bf3f6d49e73b39d');

      List<Movie> movies = (result.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();
      

      return movies;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<List<Movie>?> getTrendingMovies() async {
    Dio dio = Dio();

    try {
      var result = await dio.get(
          'https://api.themoviedb.org/3/trending/all/day?api_key=b08dd4cdf49c39367bf3f6d49e73b39d');

      List<Movie> movies = (result.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();
      

      return movies;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
