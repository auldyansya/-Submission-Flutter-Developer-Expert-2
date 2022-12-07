import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/tv.dart';
import '../../../../domain/usecases/get_tv_recommendations.dart';

part 'tv_recommendations_event.dart';

part 'tv_recommendations_state.dart';

class TvRecommendationsBloc
    extends Bloc<TvRecommendationsEvent, TvRecommendationsState> {
  final GetTvRecommendations getTvRecommendations;

  TvRecommendationsBloc(
    this.getTvRecommendations,
  ) : super(TvRecommendationsEmpty()) {
    on<FetchRecommendationsTv>((event, emit) async {
      final id = event.id;
      emit(TvRecommendationsLoading());
      final result = await getTvRecommendations.execute(id);
      result.fold(
        (failure) {
          emit(TvRecommendationsError(failure.message));
        },
        (data) {
          emit(TvRecommendationsLoaded(data));
        },
      );
    });
  }
}
