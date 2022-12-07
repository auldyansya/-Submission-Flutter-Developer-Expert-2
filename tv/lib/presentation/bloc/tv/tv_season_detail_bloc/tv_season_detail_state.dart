part of 'tv_season_detail_bloc.dart';

class TvSeasonDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class TvSeasonDetailEmpty extends TvSeasonDetailState {}

class TvSeasonDetailLoading extends TvSeasonDetailState {}

class TvSeasonDetailLoaded extends TvSeasonDetailState {
  final TvSeasonDetail result;

  TvSeasonDetailLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TvSeasonDetailError extends TvSeasonDetailState {
  final String message;

  TvSeasonDetailError(this.message);

  @override
  List<Object> get props => [message];
}
