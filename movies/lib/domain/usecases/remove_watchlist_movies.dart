import 'package:dartz/dartz.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movies_repository.dart';

import 'package:core/core.dart';

class RemoveWatchlistMovies {
  final MoviesRepository repository;

  RemoveWatchlistMovies(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlistMovies(movie);
  }
}
