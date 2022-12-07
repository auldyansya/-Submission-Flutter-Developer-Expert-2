import '../../domain/repositories/movies_repository.dart';

class GetWatchListStatusMovies {
  final MoviesRepository repository;

  GetWatchListStatusMovies(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistMovies(id);
  }
}
