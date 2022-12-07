import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_now_playing_movies.dart';

part 'movies_now_playing_event.dart';

part 'movies_now_playing_state.dart';

class MoviesNowPlayingBloc
    extends Bloc<MoviesNowPlayingEvent, MoviesNowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MoviesNowPlayingBloc(this.getNowPlayingMovies)
      : super(MoviesNowPlayingEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(MoviesNowPlayingLoading());
      final result = await getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(MoviesNowPlayingError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(MoviesNowPlayingEmpty());
          } else {
            emit(MoviesNowPlayingLoaded(data));
          }
        },
      );
    });
  }
}
