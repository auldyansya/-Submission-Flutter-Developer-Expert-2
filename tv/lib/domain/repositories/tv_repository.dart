import 'package:dartz/dartz.dart';

import '../entities/tv.dart';
import '../entities/tv_detail.dart';
import '../entities/tv_season_detail.dart';

import 'package:core/core.dart';

abstract class TvRepository {
  Future<Either<Failure, TvSeasonDetail>> getTvSeasonDetail(int id, int season);
  Future<Either<Failure, List<Tv>>> getNowPlayingTv();
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRatedTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tv);
  Future<bool> isAddedToWatchlistTv(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();

}
