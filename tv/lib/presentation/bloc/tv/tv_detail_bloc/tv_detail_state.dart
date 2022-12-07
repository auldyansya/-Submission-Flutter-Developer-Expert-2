part of 'tv_detail_bloc.dart';

class TvDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class TvDetailEmpty extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailLoaded extends TvDetailState {
  final TvDetail result;

  TvDetailLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TvDetailError extends TvDetailState {
  final String message;

  TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}
