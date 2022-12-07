part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();

  @override
  List<Object> get props => [];
}

// Watchlist Movie
class FetchWatchlistTv extends TvWatchlistEvent {}


class OnSaveWatchlistTv extends TvWatchlistEvent {
  final TvDetail tv;

  const OnSaveWatchlistTv(this.tv);

  @override
  List<Object> get props => [tv];
}


class OnRemoveWatchlistTv extends TvWatchlistEvent {
  final TvDetail tv;

  const OnRemoveWatchlistTv(this.tv);

  @override
  List<Object> get props => [tv];
}


class OnLoadWatchlistStatusTv extends TvWatchlistEvent {
  final int id;

  const OnLoadWatchlistStatusTv(this.id);

  @override
  List<Object> get props => [id];
}