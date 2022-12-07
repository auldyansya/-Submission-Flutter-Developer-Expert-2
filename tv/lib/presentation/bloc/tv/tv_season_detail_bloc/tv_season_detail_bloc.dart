import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/tv_season_detail.dart';
import '../../../../domain/usecases/get_tv_season_detail.dart';

part 'tv_season_detail_event.dart';

part 'tv_season_detail_state.dart';

class TvSeasonDetailBloc extends Bloc<TvSeasonDetailEvent, TvSeasonDetailState> {
  final GetTvSeasonDetail getMovieDetail;

  TvSeasonDetailBloc(
    this.getMovieDetail,
  ) : super(TvSeasonDetailEmpty()) {
    on<FetchSeasonDetailTv>((event, emit) async {
      final id = event.id;
      final season = event.season;
      emit(TvSeasonDetailLoading());
      final result = await getMovieDetail.execute(id, season);
      result.fold(
        (failure) {
          emit(TvSeasonDetailError(failure.message));
        },
        (data) {
          emit(TvSeasonDetailLoaded(data));
        },
      );
    });
  }
}
