import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_recommendations_bloc/tv_recommendations_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_tv_bloc_helper.dart';

void main() {
  late TvDetailBlocHelper tvDetailBlocHelper;
  late TvRecommendationsBlocHelper tvRecommendationsBlocHelper;
  late TvWatchlistBlocHelper tvWatchlistBlocHelper;

  setUp(() {
    registerFallbackValue(TvDetailStateHelper());
    registerFallbackValue(TvDetailEventHelper());
    tvDetailBlocHelper = TvDetailBlocHelper();

    registerFallbackValue(TvRecommendationsStateHelper());
    registerFallbackValue(TvRecommendationsEventHelper());
    tvRecommendationsBlocHelper = TvRecommendationsBlocHelper();

    registerFallbackValue(TvWatchlistStateHelper());
    registerFallbackValue(TvWatchlistEventHelper());
    tvWatchlistBlocHelper = TvWatchlistBlocHelper();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(
          create: (_) => tvDetailBlocHelper,
        ),
        BlocProvider<TvRecommendationsBloc>(
          create: (_) => tvRecommendationsBlocHelper,
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (_) => tvWatchlistBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    ((WidgetTester tester) async {
      when(() => tvDetailBlocHelper.state).thenReturn(TvDetailLoading());
      when(() => tvRecommendationsBlocHelper.state)
          .thenReturn(TvRecommendationsLoading());
      when(() => tvWatchlistBlocHelper.state).thenReturn(TvWatchlistLoading());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(
        makeTestableWidget(
          const TvDetailPage(
            id: 1,
          ),
        ),
      );

      await tester.pump();

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => tvDetailBlocHelper.state).thenReturn(
      TvDetailLoaded(testTvDetail),
    );
    when(() => tvRecommendationsBlocHelper.state).thenReturn(
      TvRecommendationsLoaded(testTvList),
    );
    when(() => tvWatchlistBlocHelper.state).thenReturn(
      const TvLoadWatchlist(false),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    await tester.pump();

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
        when(() => tvDetailBlocHelper.state).thenReturn(
          TvDetailLoaded(testTvDetail),
        );
        when(() => tvRecommendationsBlocHelper.state).thenReturn(
          TvRecommendationsLoaded(testTvList),
        );
        when(() => tvWatchlistBlocHelper.state).thenReturn(
          const TvLoadWatchlist(true),
        );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    await tester.pump();

    expect(watchlistButtonIcon, findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movie).thenReturn(testMovieDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockNotifier.isAddedToWatchlistMovies).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');
  //
  //   final watchlistButton = find.byType(ElevatedButton);
  //
  //   await tester.pumpWidget(_makeTestableWidget(MoviesDetailPage(id: 1)));
  //
  //   expect(find.byIcon(Icons.add), findsOneWidget);
  //
  //   await tester.tap(watchlistButton);
  //   await tester.pump();
  //
  //   expect(find.byType(SnackBar), findsOneWidget);
  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });
  //
  // testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movie).thenReturn(testMovieDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockNotifier.isAddedToWatchlistMovies).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Failed');
  //
  //   final watchlistButton = find.byType(ElevatedButton);
  //
  //   await tester.pumpWidget(_makeTestableWidget(MoviesDetailPage(id: 1)));
  //
  //   expect(find.byIcon(Icons.add), findsOneWidget);
  //
  //   await tester.tap(watchlistButton);
  //   await tester.pump();
  //
  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
