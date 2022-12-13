part of 'movies_search_bloc.dart';

abstract class MoviesSearchEvent extends Equatable {
  const MoviesSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryMoviesChanged extends MoviesSearchEvent {
  final String query;

  const OnQueryMoviesChanged(this.query);

  @override
  List<Object> get props => [query];
}

EventTransformer<T> debounceMovies<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

