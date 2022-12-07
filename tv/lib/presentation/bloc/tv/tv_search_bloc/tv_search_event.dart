part of 'tv_search_bloc.dart';

abstract class TvSearchEvent extends Equatable {
  const TvSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryTvChanged extends TvSearchEvent {
  final String query;

  const OnQueryTvChanged(this.query);

  @override
  List<Object> get props => [query];
}

EventTransformer<T> debounceTv<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class ResetTvSearch extends TvSearchEvent {}
