import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:tv/presentation/pages/tv/top_rated_tv_page.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_tv_bloc_helper.dart';

void main() {
  late TvTopRatedBlocHelper tvTopRatedBlocHelper;

  setUp(() {
    registerFallbackValue(TvTopRatedStateHelper());
    registerFallbackValue(TvTopRatedEventHelper());
    tvTopRatedBlocHelper = TvTopRatedBlocHelper();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvTopRatedBloc>(
          create: (_) => tvTopRatedBlocHelper,
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
      when(() => tvTopRatedBlocHelper.state)
          .thenReturn(TvTopRatedLoading());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(
        makeTestableWidget(const TopRatedTvPage()),
      );

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    ((WidgetTester tester) async {
      when(() => tvTopRatedBlocHelper.state)
          .thenReturn(TvTopRatedLoading());
      when(() => tvTopRatedBlocHelper.state)
          .thenReturn(TvTopRatedLoaded(testTvList));

      final listview = find.byType(ListView);

      await tester.pumpWidget(
        makeTestableWidget(const TopRatedTvPage()),
      );

      expect(listview, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display text with message when Error',
    ((WidgetTester tester) async {
      when(() => tvTopRatedBlocHelper.state)
          .thenReturn(TvTopRatedLoading());
      when(() => tvTopRatedBlocHelper.state)
          .thenReturn(TvTopRatedError("Error Message"));

      final key = find.byKey(const Key('Error Message'));

      await tester.pumpWidget(
        makeTestableWidget(const TopRatedTvPage()),
      );

      expect(key, findsOneWidget);
    }),
  );
}
