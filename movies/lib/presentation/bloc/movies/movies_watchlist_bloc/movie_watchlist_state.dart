part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MoviesWatchlistEmpty extends MovieWatchlistState {}

class MoviesWatchlistLoading extends MovieWatchlistState {}

class MoviesWatchlistError extends MovieWatchlistState {
  final String message;

  const MoviesWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesWatchlistLoaded extends MovieWatchlistState {
  final List<Movie> watchlist;

  const MoviesWatchlistLoaded(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}


class MoviesWatchlistMessage extends MovieWatchlistState {
  final String message;

  const MoviesWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesLoadWatchlist extends MovieWatchlistState {
  final bool isWatchlist;

  const MoviesLoadWatchlist(this.isWatchlist);

  @override
  List<Object> get props => [isWatchlist];
}