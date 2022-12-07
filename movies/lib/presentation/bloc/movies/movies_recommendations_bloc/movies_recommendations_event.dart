part of 'movies_recommendations_bloc.dart';

abstract class MoviesRecommendationsEvent extends Equatable {
  const MoviesRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendationsMovies extends MoviesRecommendationsEvent {
  final int id;

  const FetchRecommendationsMovies(this.id);

  @override
  List<Object> get props => [id];
}