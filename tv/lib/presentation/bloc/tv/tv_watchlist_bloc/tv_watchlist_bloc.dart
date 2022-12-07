import 'package:bloc/bloc.dart';
import '../../../../domain/usecases/get_watchlist_status_tv.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/tv.dart';
import '../../../../domain/entities/tv_detail.dart';
import '../../../../domain/usecases/get_watchlist_tv.dart';
import '../../../../domain/usecases/remove_watchlist_tv.dart';
import '../../../../domain/usecases/save_watchlist_tv.dart';

part 'tv_watchlist_event.dart';

part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTv _getWatchlistTv;
  final GetWatchListStatusTv _getWatchListStatusTv;
  final SaveWatchlistTv _saveWatchlistTv;
  final RemoveWatchlistTv _removeWatchlistTv;

  static const messageAddedToWatchlist = "Added to Watchlist";
  static const messageRemoveToWatchlist = "Removed from Watchlist";

  TvWatchlistBloc(
    this._getWatchlistTv,
    this._getWatchListStatusTv,
    this._saveWatchlistTv,
    this._removeWatchlistTv,
  ) : super(TvWatchlistEmpty()) {
    // On Watchlist
    on<FetchWatchlistTv>((event, emit) async {
      emit(TvWatchlistLoading());

      final result = await _getWatchlistTv.execute();

      result.fold((failure) => emit(TvWatchlistError(failure.message)), (data) {
        if (data.isEmpty) {
          emit(TvWatchlistEmpty());
        } else {
          emit(TvWatchlistLoaded(data));
        }
      });
    });

    on<OnLoadWatchlistStatusTv>((event, emit) async {
      final id = event.id;
      emit(TvWatchlistLoading());
      final result = await _getWatchListStatusTv.execute(id);
      emit(TvLoadWatchlist(result));
    });

    on<OnSaveWatchlistTv>((event, emit) async {
      final movie = event.tv;
      emit(TvWatchlistLoading());
      final result = await _saveWatchlistTv.execute(movie);
      result.fold(
        (failure) => emit(TvWatchlistError(failure.message)),
        (message) => emit(TvWatchlistMessage(message)),
      );
    });

    on<OnRemoveWatchlistTv>((event, emit) async {
      final movie = event.tv;
      emit(TvWatchlistLoading());
      final result = await _removeWatchlistTv.execute(movie);
      result.fold(
        (failure) => emit(TvWatchlistError(failure.message)),
        (message) => emit(TvWatchlistMessage(message)),
      );
    });
  }
}
