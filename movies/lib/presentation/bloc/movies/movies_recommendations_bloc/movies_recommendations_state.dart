part of 'movies_recommendations_bloc.dart';

class MoviesRecommendationsState extends Equatable {

  @override
  List<Object> get props => [];
}

class MoviesRecommendationsEmpty extends MoviesRecommendationsState {}

class MoviesRecommendationsLoading extends MoviesRecommendationsState {}

class MoviesRecommendationsLoaded extends MoviesRecommendationsState {
  final List<Movie> result;

  MoviesRecommendationsLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MoviesRecommendationsError extends MoviesRecommendationsState {
  final String message;

  MoviesRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}