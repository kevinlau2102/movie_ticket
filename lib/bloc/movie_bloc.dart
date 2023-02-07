import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_event.dart';
part 'movie_state.dart';
part 'movie_bloc.freezed.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(const _Initial()) {
    on<MovieEvent>((event, emit) {
      emit(state.when(initial: () => const MovieState.running(0), running: (id) {
        return event.when(started: (id) => MovieState.running(id));
      }));
    });
  }
}
