import 'package:dartz/dartz.dart';
import '../../domain/entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

import 'package:core/core.dart';

class RemoveWatchlistTv {
  final TvRepository repository;

  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlistTv(tv);
  }
}
