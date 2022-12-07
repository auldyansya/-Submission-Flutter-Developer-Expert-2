part of 'tv_top_rated_bloc.dart';

class TvTopRatedState extends Equatable {

  @override
  List<Object> get props => [];
}

class TvTopRatedEmpty extends TvTopRatedState {}

class TvTopRatedLoading extends TvTopRatedState {}

class TvTopRatedLoaded extends TvTopRatedState {
  final List<Tv> result;

  TvTopRatedLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TvTopRatedError extends TvTopRatedState {
  final String message;

  TvTopRatedError(this.message);

  @override
  List<Object> get props => [];
}
