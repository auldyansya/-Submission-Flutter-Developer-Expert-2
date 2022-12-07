import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_top_rated_movies.dart';

part 'movies_top_rated_event.dart';

part 'movies_top_rated_state.dart';

class MoviesTopRatedBloc extends Bloc<MoviesTopRatedEvent, MoviesTopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;

  MoviesTopRatedBloc(this.getTopRatedMovies) : super(MoviesTopRatedEmpty()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(MoviesTopRatedLoading());
      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(MoviesTopRatedError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(MoviesTopRatedEmpty());
          } else {
            emit(MoviesTopRatedLoaded(data));
          }
        },
      );
    });
  }
}
