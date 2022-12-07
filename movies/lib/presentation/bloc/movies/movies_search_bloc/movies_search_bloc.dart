import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/search_movies.dart';

part 'movies_search_event.dart';

part 'movies_search_state.dart';

class MoviesSearchBloc extends Bloc<MoviesSearchEvent, MoviesSearchState> {
  final SearchMovies searchMovies;

  MoviesSearchBloc(this.searchMovies) : super(MoviesSearchEmpty()) {
    on<OnQueryMoviesChanged>((event, emit) async {
      final query = event.query;

      emit(MoviesSearchLoading());
      final result = await searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(MoviesSearchError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(MoviesSearchEmpty());
          } else {
            emit(MoviesSearchLoaded(data));
          }
        },
      );
    }, transformer: debounceMovies(const Duration(milliseconds: 500)));

    on<ResetMoviesSearch>(
      (event, emit) async {
        emit(MoviesSearchEmpty());
      },
    );
  }
}
