import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/episode_model.dart';
import 'package:tv/data/models/tv_season_detail_model.dart';
import 'package:tv/domain/entities/episode.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';

void main() {
  const tTvSeasonDetailModel = TvSeasonDetailResponse(
    id: 'id',
    airDate: 'airDate',
    episodes: [
      EpisodeModel(
          airDate: 'airDate',
          episodeNumber: 1,
          name: 'name',
          overview: 'overview',
          id: 1,
          productionCode: 'productionCode',
          seasonNumber: 1,
          stillPath: 'stillPath',
          voteAverage: 1,
          voteCount: 1)
    ],
    name: 'name',
    overview: 'overview',
    seasonsModelId: 1,
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  const tTvSeasonDetail = TvSeasonDetail(
    id: 'id',
    airDate: 'airDate',
    episodes: [
      Episode(
          airDate: 'airDate',
          episodeNumber: 1,
          name: 'name',
          overview: 'overview',
          id: 1,
          productionCode: 'productionCode',
          seasonNumber: 1,
          stillPath: 'stillPath',
          voteAverage: 1,
          voteCount: 1)
    ],
    name: 'name',
    overview: 'overview',
    seasonsModelId: 1,
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  test('should be a subclass of Tv Season Detail entity', () async {
    final result = tTvSeasonDetailModel.toEntity();
    expect(result, tTvSeasonDetail);
  });
}
