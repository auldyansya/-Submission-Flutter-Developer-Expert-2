part of 'tv_now_playing_bloc.dart';

class TvNowPlayingState extends Equatable {

  @override
  List<Object> get props => [];
}

class TvNowPlayingEmpty extends TvNowPlayingState {}

class TvNowPlayingLoading extends TvNowPlayingState {}

class TvNowPlayingLoaded extends TvNowPlayingState {
  final List<Tv> result;

  TvNowPlayingLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TvNowPlayingError extends TvNowPlayingState {
  final String message;

  TvNowPlayingError(this.message);

  @override
  List<Object> get props => [];
}
