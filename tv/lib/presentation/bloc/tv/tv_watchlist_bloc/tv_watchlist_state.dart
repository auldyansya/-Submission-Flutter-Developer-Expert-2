part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class TvWatchlistEmpty extends TvWatchlistState {}

class TvWatchlistLoading extends TvWatchlistState {}

class TvWatchlistError extends TvWatchlistState {
  final String message;

  const TvWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchlistLoaded extends TvWatchlistState {
  final List<Tv> watchlist;

  const TvWatchlistLoaded(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

class TvWatchlistMessage extends TvWatchlistState {
  final String message;

  const TvWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

class TvLoadWatchlist extends TvWatchlistState {
  final bool isWatchlist;

  const TvLoadWatchlist(this.isWatchlist);

  @override
  List<Object> get props => [isWatchlist];
}
