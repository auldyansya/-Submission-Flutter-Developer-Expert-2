import 'package:dartz/dartz.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';


import 'package:core/core.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, String>> saveWatchlistMovies(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlistMovies(MovieDetail movie);
  Future<bool> isAddedToWatchlistMovies(int id);
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
}
