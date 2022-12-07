import 'package:dartz/dartz.dart';
import '../../domain/entities/tv.dart';
import '../repositories/tv_repository.dart';

import 'package:core/core.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
