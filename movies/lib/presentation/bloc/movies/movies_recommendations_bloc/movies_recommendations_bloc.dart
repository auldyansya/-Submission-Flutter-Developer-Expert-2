import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_movie_recommendations.dart';

part 'movies_recommendations_event.dart';

part 'movies_recommendations_state.dart';

class MoviesRecommendationsBloc
    extends Bloc<MoviesRecommendationsEvent, MoviesRecommendationsState> {
  final GetMovieRecommendations getMovieRecommendations;

  MoviesRecommendationsBloc(
    this.getMovieRecommendations,
  ) : super(MoviesRecommendationsEmpty()) {
    on<FetchRecommendationsMovies>((event, emit) async {
      final id = event.id;
      emit(MoviesRecommendationsLoading());
      final result = await getMovieRecommendations.execute(id);
      result.fold(
        (failure) {
          emit(MoviesRecommendationsError(failure.message));
        },
        (data) {
          emit(MoviesRecommendationsLoaded(data));
        },
      );
    });
  }
}
