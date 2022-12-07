import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/movies/movies_now_playing_bloc/movies_now_playing_bloc.dart';
import 'package:movies/presentation/pages/movies/now_playing_movies_page.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_movies_bloc_helper.dart';

void main() {
  late MoviesNowPlayingBlocHelper moviesNowPlayingBlocHelper;

  setUp(() {
    registerFallbackValue(MoviesNowPlayingStateHelper());
    registerFallbackValue(MoviesNowPlayingEventHelper());
    moviesNowPlayingBlocHelper = MoviesNowPlayingBlocHelper();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesNowPlayingBloc>(
          create: (_) => moviesNowPlayingBlocHelper,
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
      when(() => moviesNowPlayingBlocHelper.state)
          .thenReturn(MoviesNowPlayingLoading());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(
        makeTestableWidget(const NowPlayingMoviesPage()),
      );

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    ((WidgetTester tester) async {
      when(() => moviesNowPlayingBlocHelper.state)
          .thenReturn(MoviesNowPlayingLoading());
      when(() => moviesNowPlayingBlocHelper.state)
          .thenReturn(MoviesNowPlayingLoaded(testMovieList));

      final listview = find.byType(ListView);

      await tester.pumpWidget(
        makeTestableWidget(const NowPlayingMoviesPage()),
      );

      expect(listview, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display text with message when Error',
    ((WidgetTester tester) async {
      when(() => moviesNowPlayingBlocHelper.state)
          .thenReturn(MoviesNowPlayingLoading());
      when(() => moviesNowPlayingBlocHelper.state)
          .thenReturn(MoviesNowPlayingError("Error Message"));

      final key = find.byKey(const Key('Error Message'));

      await tester.pumpWidget(
        makeTestableWidget(const NowPlayingMoviesPage()),
      );

      expect(key, findsOneWidget);
    }),
  );
}
