import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/entities/genre.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie(
      {required int? id,
      required String? title,
      required String? name,
      required String? overview,
      required String? original_language,
      required double? vote_average,
      required String? poster_path,
      required String? backdrop_path,
      required int? runtime,
      @Default([]) List<Genre> genres}) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
