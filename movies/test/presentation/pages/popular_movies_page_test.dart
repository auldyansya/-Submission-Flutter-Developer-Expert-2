import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/movies/movies_popular_bloc/movies_popular_bloc.dart';
import 'package:movies/presentation/pages/movies/popular_movies_page.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_movies_bloc_helper.dart';

void main() {
  late MoviesPopularBlocHelper moviesPopularBlocHelper;

  setUp(() {
    registerFallbackValue(MoviesPopularStateHelper());
    registerFallbackValue(MoviesPopularEventHelper());
    moviesPopularBlocHelper = MoviesPopularBlocHelper();

  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesPopularBloc>(
          create: (_) => moviesPopularBlocHelper,
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
      when(() => moviesPopularBlocHelper.state).thenReturn(MoviesPopularLoading());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(
        makeTestableWidget(const PopularMoviesPage()),
      );

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    ((WidgetTester tester) async {
      when(() => moviesPopularBlocHelper.state).thenReturn(MoviesPopularLoading());
      when(() => moviesPopularBlocHelper.state)
          .thenReturn(MoviesPopularLoaded(testMovieList));

      final listview = find.byType(ListView);

      await tester.pumpWidget(
        makeTestableWidget(const PopularMoviesPage()),
      );

      expect(listview, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display text with message when Error',
    ((WidgetTester tester) async {
      when(() => moviesPopularBlocHelper.state).thenReturn(MoviesPopularLoading());
      when(() => moviesPopularBlocHelper.state)
          .thenReturn( MoviesPopularError("Error Message"));

      final key = find.byKey(const Key('Error Message'));

      await tester.pumpWidget(
        makeTestableWidget( const PopularMoviesPage()),
      );

      expect(key, findsOneWidget);
    }),
  );

}
