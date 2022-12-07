import 'package:dartz/dartz.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movies_repository.dart';

import 'package:core/core.dart';

class GetMovieDetail {
  final MoviesRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
