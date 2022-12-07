import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/tv.dart';
import '../../../../domain/usecases/get_top_rated_tv.dart';

part 'tv_top_rated_event.dart';

part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTopRatedTv getTopRatedTv;

  TvTopRatedBloc(this.getTopRatedTv) : super(TvTopRatedEmpty()) {
    on<FetchTopRatedTv>((event, emit) async {
      emit(TvTopRatedLoading());
      final result = await getTopRatedTv.execute();

      result.fold(
        (failure) {
          emit(TvTopRatedError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(TvTopRatedEmpty());
          } else {
            emit(TvTopRatedLoaded(data));
          }
        },
      );
    });
  }
}
