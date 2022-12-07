part of 'movies_top_rated_bloc.dart';

class MoviesTopRatedState extends Equatable {

  @override
  List<Object> get props => [];
}

class MoviesTopRatedEmpty extends MoviesTopRatedState {}

class MoviesTopRatedLoading extends MoviesTopRatedState {}

class MoviesTopRatedLoaded extends MoviesTopRatedState {
  final List<Movie> result;

  MoviesTopRatedLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MoviesTopRatedError extends MoviesTopRatedState {
  final String message;

  MoviesTopRatedError(this.message);

  @override
  List<Object> get props => [];
}
