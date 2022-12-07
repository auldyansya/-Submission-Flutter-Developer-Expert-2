import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/tv.dart';
import '../../../../domain/usecases/get_now_playing_tv.dart';

part 'tv_now_playing_event.dart';

part 'tv_now_playing_state.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  final GetNowPlayingTv getNowPlayingTv;

  TvNowPlayingBloc(this.getNowPlayingTv) : super(TvNowPlayingEmpty()) {
    on<FetchNowPlayingTv>((event, emit) async {
      emit(TvNowPlayingLoading());
      final result = await getNowPlayingTv.execute();

      result.fold(
        (failure) {
          emit(TvNowPlayingError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(TvNowPlayingEmpty());
          } else {
            emit(TvNowPlayingLoaded(data));
          }
        },
      );
    });
  }
}
