import 'package:core/core.dart';
import '../../data/datasources/db/movies_database_helper.dart';
import '../../data/models/movie_table.dart';

abstract class MoviesLocalDataSource {
  Future<String> insertWatchlistMovies(MovieTable movies);
  Future<String> removeWatchlistMovies(MovieTable movies);
  Future<MovieTable?> getMoviesById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
}

class MoviesLocalDataSourceImpl implements MoviesLocalDataSource {
  final MoviesDatabaseHelper databaseHelper;

  MoviesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistMovies(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlistMovies(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistMovies(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlistMovies(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMoviesById(int id) async {
    final result = await databaseHelper.getMoviesById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

}
