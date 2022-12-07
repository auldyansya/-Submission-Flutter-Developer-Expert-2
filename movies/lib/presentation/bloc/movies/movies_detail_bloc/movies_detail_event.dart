part of 'movies_detail_bloc.dart';

abstract class MoviesDetailEvent extends Equatable {
  const MoviesDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailMovies extends MoviesDetailEvent {
  final int id;

  const FetchDetailMovies(this.id);

  @override
  List<Object> get props => [id];
}
