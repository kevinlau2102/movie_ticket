// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Movie _$$_MovieFromJson(Map<String, dynamic> json) => _$_Movie(
      id: json['id'] as int?,
      title: json['title'] as String?,
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      original_language: json['original_language'] as String?,
      vote_average: (json['vote_average'] as num?)?.toDouble(),
      poster_path: json['poster_path'] as String?,
      backdrop_path: json['backdrop_path'] as String?,
      runtime: json['runtime'] as int?,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_MovieToJson(_$_Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'name': instance.name,
      'overview': instance.overview,
      'original_language': instance.original_language,
      'vote_average': instance.vote_average,
      'poster_path': instance.poster_path,
      'backdrop_path': instance.backdrop_path,
      'runtime': instance.runtime,
      'genres': instance.genres,
    };
