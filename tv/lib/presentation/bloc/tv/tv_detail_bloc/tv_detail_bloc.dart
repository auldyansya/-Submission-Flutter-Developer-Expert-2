import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/tv_detail.dart';
import '../../../../domain/usecases/get_tv_detail.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getMovieDetail;

  TvDetailBloc(
    this.getMovieDetail,
  ) : super(TvDetailLoading()) {
    on<FetchDetailTv>((event, emit) async {
      final id = event.id;
      emit(TvDetailLoading());
      final result = await getMovieDetail.execute(id);
      result.fold(
        (failure) {
          emit(TvDetailError(failure.message));
        },
        (data) {
          emit(TvDetailLoaded(data));
        },
      );
    });
  }
}
