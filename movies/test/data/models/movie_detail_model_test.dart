import 'package:movies/data/models/genre_model.dart';
import 'package:movies/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/domain/entities/genre.dart';
import 'package:movies/domain/entities/movie_detail.dart';

void main() {
  const tMovieDetailModel = MovieDetailResponse(
    adult: true,
    backdropPath: 'backdropPath',
    genres: [GenreModel(id: 1, name: 'name')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 1,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  const tMovieDetail = MovieDetail(
    adult: true,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'name')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 1,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Movie Detail entity', () async {
    final result = tMovieDetailModel.toEntity();
    expect(result, tMovieDetail);
  });
}
