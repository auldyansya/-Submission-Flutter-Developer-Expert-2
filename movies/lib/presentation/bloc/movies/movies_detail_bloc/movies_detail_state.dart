part of 'movies_detail_bloc.dart';

class MoviesDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class MoviesDetailEmpty extends MoviesDetailState {}

class MoviesDetailLoading extends MoviesDetailState {}

class MoviesDetailLoaded extends MoviesDetailState {
  final MovieDetail result;

  MoviesDetailLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MoviesDetailError extends MoviesDetailState {
  final String message;

  MoviesDetailError(this.message);

  @override
  List<Object> get props => [message];
}
