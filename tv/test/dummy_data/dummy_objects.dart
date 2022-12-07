
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/episode.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';

final testTv = Tv(
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalName: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  firstAirDate: '2002-05-01',
  name: 'Spider-Man',
  voteAverage: 7.2,
  voteCount: 13507,
  originalLanguage: 'EN',
);

final testTvList = [testTv];

const testTvDetail = TvDetail(
  backdropPath: 'backdropPath',
  firstAirDate: 'firstAirDate',
  genres: [Genre(id: 1, name: 'Action')],
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
        seasonNumber: 1)
  ],
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

const testTvSeasonDetail = TvSeasonDetail(
  id: "1",
  airDate: "22-10-2022",
  episodes: [
    Episode(
      airDate: 'airdate',
      episodeNumber: 1,
      name: 'name',
      overview: 'overview',
      id: 1,
      productionCode: 'prductiocode',
      seasonNumber: 1,
      stillPath: 'stillpath',
      voteAverage: 1.0,
      voteCount: 1,
    )
  ],
  name: 'name',
  overview: 'overview',
  seasonsModelId: 1,
  posterPath: 'posterPath',
  seasonNumber: 1,
);
