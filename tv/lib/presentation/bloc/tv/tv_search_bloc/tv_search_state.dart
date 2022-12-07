part of 'tv_search_bloc.dart';

class TvSearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class TvSearchEmpty extends TvSearchState {}

class TvSearchLoading extends TvSearchState {}

class TvSearchLoaded extends TvSearchState {
  final List<Tv> result;

  TvSearchLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TvSearchError extends TvSearchState {
  final String message;

  TvSearchError(this.message);

  @override
  List<Object> get props => [];
}
