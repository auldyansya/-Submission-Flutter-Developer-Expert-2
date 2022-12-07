part of 'movies_now_playing_bloc.dart';

abstract class MoviesNowPlayingEvent extends Equatable {
  const MoviesNowPlayingEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingMovies extends MoviesNowPlayingEvent {
}
