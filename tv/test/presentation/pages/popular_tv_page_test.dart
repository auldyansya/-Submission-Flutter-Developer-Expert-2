import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:tv/presentation/pages/tv/popular_tv_page.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_tv_bloc_helper.dart';

void main() {
  late TvPopularBlocHelper tvPopularBlocHelper;

  setUp(() {
    registerFallbackValue(TvPopularStateHelper());
    registerFallbackValue(TvPopularEventHelper());
    tvPopularBlocHelper = TvPopularBlocHelper();

  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvPopularBloc>(
          create: (_) => tvPopularBlocHelper,
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
      when(() => tvPopularBlocHelper.state).thenReturn(TvPopularLoading());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(
        makeTestableWidget(const PopularTvPage()),
      );

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    ((WidgetTester tester) async {
      when(() => tvPopularBlocHelper.state).thenReturn(TvPopularLoading());
      when(() => tvPopularBlocHelper.state)
          .thenReturn(TvPopularLoaded(testTvList));

      final listview = find.byType(ListView);

      await tester.pumpWidget(
        makeTestableWidget(const PopularTvPage()),
      );

      expect(listview, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display text with message when Error',
    ((WidgetTester tester) async {
      when(() => tvPopularBlocHelper.state).thenReturn(TvPopularLoading());
      when(() => tvPopularBlocHelper.state)
          .thenReturn( TvPopularError("Error Message"));

      final key = find.byKey(const Key('Error Message'));

      await tester.pumpWidget(
        makeTestableWidget( const PopularTvPage()),
      );

      expect(key, findsOneWidget);
    }),
  );

}
