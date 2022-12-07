import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/tv.dart';
import '../../../../domain/usecases/get_popular_tv.dart';

part 'tv_popular_event.dart';

part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTv getPopularTv;

  TvPopularBloc(this.getPopularTv) : super(TvPopularEmpty()) {
    on<FetchPopularTv>((event, emit) async {
      emit(TvPopularLoading());
      final result = await getPopularTv.execute();

      result.fold(
        (failure) {
          emit(TvPopularError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(TvPopularEmpty());
          } else {
            emit(TvPopularLoaded(data));
          }
        },
      );
    });
  }
}
