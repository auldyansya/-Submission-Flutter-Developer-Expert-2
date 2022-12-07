part of 'tv_popular_bloc.dart';

class TvPopularState extends Equatable {

  @override
  List<Object> get props => [];
}

class TvPopularEmpty extends TvPopularState {}

class TvPopularLoading extends TvPopularState {}

class TvPopularLoaded extends TvPopularState {
  final List<Tv> result;

  TvPopularLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TvPopularError extends TvPopularState {
  final String message;

  TvPopularError(this.message);

  @override
  List<Object> get props => [];
}
