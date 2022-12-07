import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'package:movies/movies.dart';
import 'package:tv/tv.dart';


final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MoviesNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvSeasonDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );


  // use case
  locator.registerLazySingleton(() => GetTvSeasonDetail(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovies(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovies(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
        () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MoviesLocalDataSource>(
      () => MoviesLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
          () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
          () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<MoviesDatabaseHelper>(() => MoviesDatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
