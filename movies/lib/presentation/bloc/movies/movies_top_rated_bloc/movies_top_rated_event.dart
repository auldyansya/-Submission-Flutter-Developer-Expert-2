part of 'movies_top_rated_bloc.dart';

abstract class MoviesTopRatedEvent extends Equatable {
  const MoviesTopRatedEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRatedMovies extends MoviesTopRatedEvent {
}
