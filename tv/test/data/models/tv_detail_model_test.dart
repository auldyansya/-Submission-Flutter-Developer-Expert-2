import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/genre_model.dart';
import 'package:tv/data/models/season_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv_detail.dart';

void main() {
  const tTvDetailModel = TvDetailResponse(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [GenreModel(id: 1, name: 'name')],
    id: 1,
    originalName: 'originalName',
    name: 'name',
    originalLanguage: 'originalLanguage',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    seasons: [
      SeasonModel(
        airDate: 'airDate',
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      )
    ],
    voteAverage: 1,
    voteCount: 1,
  );

  const tTvDetail = TvDetail(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [Genre(id: 1, name: 'name')],
    id: 1,
    originalName: 'originalName',
    name: 'name',
    originalLanguage: 'originalLanguage',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    seasons: [
      Season(
        airDate: 'airDate',
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      )
    ],
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Tv Detail entity', () async {
    final result = tTvDetailModel.toEntity();
    expect(result, tTvDetail);
  });
}
