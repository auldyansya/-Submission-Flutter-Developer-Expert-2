import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_popular_movies.dart';

part 'movies_popular_event.dart';

part 'movies_popular_state.dart';

class MoviesPopularBloc extends Bloc<MoviesPopularEvent, MoviesPopularState> {
  final GetPopularMovies getPopularMovies;

  MoviesPopularBloc(this.getPopularMovies) : super(MoviesPopularEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(MoviesPopularLoading());
      final result = await getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(MoviesPopularError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(MoviesPopularEmpty());
          } else {
            emit(MoviesPopularLoaded(data));
          }
        },
      );
    });
  }
}
