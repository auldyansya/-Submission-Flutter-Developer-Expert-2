part of 'movies_search_bloc.dart';

class MoviesSearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class MoviesSearchEmpty extends MoviesSearchState {}

class MoviesSearchLoading extends MoviesSearchState {}

class MoviesSearchLoaded extends MoviesSearchState {
  final List<Movie> result;

  MoviesSearchLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MoviesSearchError extends MoviesSearchState {
  final String message;

  MoviesSearchError(this.message);

  @override
  List<Object> get props => [];
}
