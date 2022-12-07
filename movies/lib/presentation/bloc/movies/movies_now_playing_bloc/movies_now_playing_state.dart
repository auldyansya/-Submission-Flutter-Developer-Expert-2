part of 'movies_now_playing_bloc.dart';

class MoviesNowPlayingState extends Equatable {

  @override
  List<Object> get props => [];
}

class MoviesNowPlayingEmpty extends MoviesNowPlayingState {}

class MoviesNowPlayingLoading extends MoviesNowPlayingState {}

class MoviesNowPlayingLoaded extends MoviesNowPlayingState {
  final List<Movie> result;

  MoviesNowPlayingLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MoviesNowPlayingError extends MoviesNowPlayingState {
  final String message;

  MoviesNowPlayingError(this.message);

  @override
  List<Object> get props => [];
}
