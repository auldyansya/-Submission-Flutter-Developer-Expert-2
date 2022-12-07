import 'package:dartz/dartz.dart';
import '../repositories/tv_repository.dart';

import '../entities/tv_season_detail.dart';

import 'package:core/core.dart';

class GetTvSeasonDetail {
  final TvRepository repository;

  GetTvSeasonDetail(this.repository);

  Future<Either<Failure, TvSeasonDetail>> execute(int id, int season) {
    return repository.getTvSeasonDetail(id, season);
 }
}
