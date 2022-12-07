import 'package:bloc/bloc.dart';
import '../../../../domain/usecases/get_watchlist_status_movies.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/movie.dart';
import '../../../../domain/entities/movie_detail.dart';
import '../../../../domain/usecases/get_watchlist_movies.dart';
import '../../../../domain/usecases/remove_watchlist_movies.dart';
import '../../../../domain/usecases/save_watchlist_movies.dart';

part 'movie_watchlist_event.dart';

part 'movie_watchlist_state.dart';

class MovieWatchlistBloc extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatusMovies _getWatchListStatusMovies;
  final SaveWatchlistMovies _saveWatchlistMovies;
  final RemoveWatchlistMovies _removeWatchlistMovies;

  static const messageAddedToWatchlist = "Added to Watchlist";
  static const messageRemoveToWatchlist = "Removed from Watchlist";

  MovieWatchlistBloc(
      this._getWatchlistMovies,
      this._getWatchListStatusMovies,
      this._saveWatchlistMovies,
      this._removeWatchlistMovies,
      ) : super(MoviesWatchlistEmpty()) {
    // On Watchlist
    on<FetchWatchlistMovies>((event, emit) async {
      emit(MoviesWatchlistLoading());

      final result = await _getWatchlistMovies.execute();

      result.fold(
            (failure) => emit(MoviesWatchlistError(failure.message)),
            (data) {
              if (data.isEmpty) {
                emit(MoviesWatchlistEmpty());
              } else {
                emit(MoviesWatchlistLoaded(data));
              }
            });
    });

    // On Load Status
    on<OnLoadWatchlistStatusMovies>((event, emit) async {
      final id = event.id;
      emit(MoviesWatchlistLoading());
      final result = await _getWatchListStatusMovies.execute(id);
      emit(MoviesLoadWatchlist(result));
    });

    //  On Save Watchlist
    on<OnSaveWatchlistMovies>((event, emit) async {
      final movie = event.movie;
      emit(MoviesWatchlistLoading());
      final result = await _saveWatchlistMovies.execute(movie);
      result.fold(
            (failure) => emit(MoviesWatchlistError(failure.message)),
            (message) => emit(MoviesWatchlistMessage(message)),
      );
    });

    // On Remove Watchlist
    on<OnRemoveWatchlistMovies>((event, emit) async {
      final movie = event.movie;
      emit(MoviesWatchlistLoading());
      final result = await _removeWatchlistMovies.execute(movie);
      result.fold(
            (failure) => emit(MoviesWatchlistError(failure.message)),
            (message) => emit(MoviesWatchlistMessage(message)),
      );
    });
  }
}