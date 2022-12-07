import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:tv/presentation/pages/tv/now_playing_tv_page.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_tv_bloc_helper.dart';

void main() {
  late TvNowPlayingBlocHelper tvNowPlayingBlocHelper;

  setUp(() {
    registerFallbackValue(TvNowPlayingStateHelper());
    registerFallbackValue(TvNowPlayingEventHelper());
    tvNowPlayingBlocHelper = TvNowPlayingBlocHelper();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvNowPlayingBloc>(
          create: (_) => tvNowPlayingBlocHelper,
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
      when(() => tvNowPlayingBlocHelper.state)
          .thenReturn(TvNowPlayingLoading());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(
        makeTestableWidget(const NowPlayingTvPage()),
      );

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    ((WidgetTester tester) async {
      when(() => tvNowPlayingBlocHelper.state)
          .thenReturn(TvNowPlayingLoading());
      when(() => tvNowPlayingBlocHelper.state)
          .thenReturn(TvNowPlayingLoaded(testTvList));

      final listview = find.byType(ListView);

      await tester.pumpWidget(
        makeTestableWidget(const NowPlayingTvPage()),
      );

      expect(listview, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display text with message when Error',
    ((WidgetTester tester) async {
      when(() => tvNowPlayingBlocHelper.state)
          .thenReturn(TvNowPlayingLoading());
      when(() => tvNowPlayingBlocHelper.state)
          .thenReturn(TvNowPlayingError("Error Message"));

      final key = find.byKey(const Key('Error Message'));

      await tester.pumpWidget(
        makeTestableWidget(const NowPlayingTvPage()),
      );

      expect(key, findsOneWidget);
    }),
  );
}
