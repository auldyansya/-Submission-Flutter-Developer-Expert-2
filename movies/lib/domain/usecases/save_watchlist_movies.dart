import 'package:dartz/dartz.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movies_repository.dart';

import 'package:core/core.dart';

class SaveWatchlistMovies {
  final MoviesRepository repository;

  SaveWatchlistMovies(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlistMovies(movie);
  }
}
