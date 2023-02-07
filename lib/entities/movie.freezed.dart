// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return _Movie.fromJson(json);
}

/// @nodoc
mixin _$Movie {
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  String? get original_language => throw _privateConstructorUsedError;
  double? get vote_average => throw _privateConstructorUsedError;
  String? get poster_path => throw _privateConstructorUsedError;
  String? get backdrop_path => throw _privateConstructorUsedError;
  int? get runtime => throw _privateConstructorUsedError;
  List<Genre> get genres => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieCopyWith<Movie> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieCopyWith<$Res> {
  factory $MovieCopyWith(Movie value, $Res Function(Movie) then) =
      _$MovieCopyWithImpl<$Res, Movie>;
  @useResult
  $Res call(
      {int? id,
      String? title,
      String? name,
      String? overview,
      String? original_language,
      double? vote_average,
      String? poster_path,
      String? backdrop_path,
      int? runtime,
      List<Genre> genres});
}

/// @nodoc
class _$MovieCopyWithImpl<$Res, $Val extends Movie>
    implements $MovieCopyWith<$Res> {
  _$MovieCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? name = freezed,
    Object? overview = freezed,
    Object? original_language = freezed,
    Object? vote_average = freezed,
    Object? poster_path = freezed,
    Object? backdrop_path = freezed,
    Object? runtime = freezed,
    Object? genres = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      original_language: freezed == original_language
          ? _value.original_language
          : original_language // ignore: cast_nullable_to_non_nullable
              as String?,
      vote_average: freezed == vote_average
          ? _value.vote_average
          : vote_average // ignore: cast_nullable_to_non_nullable
              as double?,
      poster_path: freezed == poster_path
          ? _value.poster_path
          : poster_path // ignore: cast_nullable_to_non_nullable
              as String?,
      backdrop_path: freezed == backdrop_path
          ? _value.backdrop_path
          : backdrop_path // ignore: cast_nullable_to_non_nullable
              as String?,
      runtime: freezed == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int?,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<Genre>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MovieCopyWith<$Res> implements $MovieCopyWith<$Res> {
  factory _$$_MovieCopyWith(_$_Movie value, $Res Function(_$_Movie) then) =
      __$$_MovieCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? title,
      String? name,
      String? overview,
      String? original_language,
      double? vote_average,
      String? poster_path,
      String? backdrop_path,
      int? runtime,
      List<Genre> genres});
}

/// @nodoc
class __$$_MovieCopyWithImpl<$Res> extends _$MovieCopyWithImpl<$Res, _$_Movie>
    implements _$$_MovieCopyWith<$Res> {
  __$$_MovieCopyWithImpl(_$_Movie _value, $Res Function(_$_Movie) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? name = freezed,
    Object? overview = freezed,
    Object? original_language = freezed,
    Object? vote_average = freezed,
    Object? poster_path = freezed,
    Object? backdrop_path = freezed,
    Object? runtime = freezed,
    Object? genres = null,
  }) {
    return _then(_$_Movie(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      original_language: freezed == original_language
          ? _value.original_language
          : original_language // ignore: cast_nullable_to_non_nullable
              as String?,
      vote_average: freezed == vote_average
          ? _value.vote_average
          : vote_average // ignore: cast_nullable_to_non_nullable
              as double?,
      poster_path: freezed == poster_path
          ? _value.poster_path
          : poster_path // ignore: cast_nullable_to_non_nullable
              as String?,
      backdrop_path: freezed == backdrop_path
          ? _value.backdrop_path
          : backdrop_path // ignore: cast_nullable_to_non_nullable
              as String?,
      runtime: freezed == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int?,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<Genre>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Movie implements _Movie {
  const _$_Movie(
      {required this.id,
      required this.title,
      required this.name,
      required this.overview,
      required this.original_language,
      required this.vote_average,
      required this.poster_path,
      required this.backdrop_path,
      required this.runtime,
      final List<Genre> genres = const []})
      : _genres = genres;

  factory _$_Movie.fromJson(Map<String, dynamic> json) =>
      _$$_MovieFromJson(json);

  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? name;
  @override
  final String? overview;
  @override
  final String? original_language;
  @override
  final double? vote_average;
  @override
  final String? poster_path;
  @override
  final String? backdrop_path;
  @override
  final int? runtime;
  final List<Genre> _genres;
  @override
  @JsonKey()
  List<Genre> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, name: $name, overview: $overview, original_language: $original_language, vote_average: $vote_average, poster_path: $poster_path, backdrop_path: $backdrop_path, runtime: $runtime, genres: $genres)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Movie &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.original_language, original_language) ||
                other.original_language == original_language) &&
            (identical(other.vote_average, vote_average) ||
                other.vote_average == vote_average) &&
            (identical(other.poster_path, poster_path) ||
                other.poster_path == poster_path) &&
            (identical(other.backdrop_path, backdrop_path) ||
                other.backdrop_path == backdrop_path) &&
            (identical(other.runtime, runtime) || other.runtime == runtime) &&
            const DeepCollectionEquality().equals(other._genres, _genres));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      name,
      overview,
      original_language,
      vote_average,
      poster_path,
      backdrop_path,
      runtime,
      const DeepCollectionEquality().hash(_genres));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MovieCopyWith<_$_Movie> get copyWith =>
      __$$_MovieCopyWithImpl<_$_Movie>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MovieToJson(
      this,
    );
  }
}

abstract class _Movie implements Movie {
  const factory _Movie(
      {required final int? id,
      required final String? title,
      required final String? name,
      required final String? overview,
      required final String? original_language,
      required final double? vote_average,
      required final String? poster_path,
      required final String? backdrop_path,
      required final int? runtime,
      final List<Genre> genres}) = _$_Movie;

  factory _Movie.fromJson(Map<String, dynamic> json) = _$_Movie.fromJson;

  @override
  int? get id;
  @override
  String? get title;
  @override
  String? get name;
  @override
  String? get overview;
  @override
  String? get original_language;
  @override
  double? get vote_average;
  @override
  String? get poster_path;
  @override
  String? get backdrop_path;
  @override
  int? get runtime;
  @override
  List<Genre> get genres;
  @override
  @JsonKey(ignore: true)
  _$$_MovieCopyWith<_$_Movie> get copyWith =>
      throw _privateConstructorUsedError;
}
