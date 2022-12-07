part of 'movies_popular_bloc.dart';

class MoviesPopularState extends Equatable {

  @override
  List<Object> get props => [];
}

class MoviesPopularEmpty extends MoviesPopularState {}

class MoviesPopularLoading extends MoviesPopularState {}

class MoviesPopularLoaded extends MoviesPopularState {
  final List<Movie> result;

  MoviesPopularLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MoviesPopularError extends MoviesPopularState {
  final String message;

  MoviesPopularError(this.message);

  @override
  List<Object> get props => [];
}
