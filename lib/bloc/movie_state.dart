part of 'movie_bloc.dart';

@freezed
class MovieState with _$MovieState {
  const factory MovieState.initial() = _Initial;
  const factory MovieState.running(int id) = _Running;
}
