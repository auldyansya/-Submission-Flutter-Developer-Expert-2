import 'package:dartz/dartz.dart';
import '../../domain/entities/tv.dart';
import '../repositories/tv_repository.dart';

import 'package:core/core.dart';

class GetPopularTv {
  final TvRepository repository;

  GetPopularTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTv();
  }
}
