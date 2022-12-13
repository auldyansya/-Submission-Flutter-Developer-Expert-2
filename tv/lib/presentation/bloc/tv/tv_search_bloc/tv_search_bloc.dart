import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/entities/tv.dart';
import '../../../../domain/usecases/search_tv.dart';

part 'tv_search_event.dart';

part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv searchTv;

  TvSearchBloc(this.searchTv) : super(TvSearchEmpty()) {
    on<OnQueryTvChanged>((event, emit) async {
      final query = event.query;

      emit(TvSearchLoading());
      final result = await searchTv.execute(query);

      result.fold(
        (failure) {
          emit(TvSearchError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(TvSearchEmpty());
          } else {
            emit(TvSearchLoaded(data));
          }
        },
      );
    }, transformer: debounceTv(const Duration(milliseconds: 500)));
  }
}
