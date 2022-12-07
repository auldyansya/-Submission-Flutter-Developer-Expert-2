part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

// Watchlist Movie
class FetchWatchlistMovies extends MovieWatchlistEvent {}

// Save Watchlist Movie Event
class OnSaveWatchlistMovies extends MovieWatchlistEvent {
  final MovieDetail movie;

  const OnSaveWatchlistMovies(this.movie);

  @override
  List<Object> get props => [movie];
}

// Remove Watchlist Movie Event
class OnRemoveWatchlistMovies extends MovieWatchlistEvent {
  final MovieDetail movie;

  const OnRemoveWatchlistMovies(this.movie);

  @override
  List<Object> get props => [movie];
}

// Load Watchlist Movie Event
class OnLoadWatchlistStatusMovies extends MovieWatchlistEvent {
  final int id;

  const OnLoadWatchlistStatusMovies(this.id);

  @override
  List<Object> get props => [id];
}