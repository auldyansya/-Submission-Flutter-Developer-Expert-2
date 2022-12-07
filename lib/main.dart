import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:tv/tv.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<TvSeasonDetailBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<TvWatchlistBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<TvRecommendationsBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MoviesDetailBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MoviesRecommendationsBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MoviesTopRatedBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MoviesNowPlayingBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MoviesPopularBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<MoviesSearchBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<TvTopRatedBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<TvNowPlayingBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<TvPopularBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviesPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeTvPage.routeName:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case NowPlayingTvPage.routeName:
              return CupertinoPageRoute(builder: (_) => NowPlayingTvPage());
            case PopularTvPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TopRatedTvPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case SearchTvPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case WatchlistTvPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case EpisodeTvPage.routeName:
              final args = settings.arguments as Map;
              final id = args['id'];
              final season = args['season'];
              return MaterialPageRoute(
                builder: (_) => EpisodeTvPage(id: id, season: season),
                settings: settings,
              );
            case SeasonTvPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SeasonTvPage(id: id),
                settings: settings,
              );
            case TvDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case HomeMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => HomeMoviesPage());
            case NowPlayingMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => NowPlayingMoviesPage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case SearchMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchMoviesPage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case MoviesDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MoviesDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
