import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/presentation/bloc/tv/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistTv, GetWatchListStatusTv, SaveWatchlistTv, RemoveWatchlistTv])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    tvWatchlistBloc = TvWatchlistBloc(mockGetWatchlistTv,
        mockGetWatchListStatusTv, mockSaveWatchlistTv, mockRemoveWatchlistTv);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(tvWatchlistBloc.state, TvWatchlistEmpty());
  });

  group("Get Watchlist Tv", () {
    blocTest<TvWatchlistBloc, TvWatchlistState>(
      "Should emit [Loading, Loaded] when data is gotten successfully",
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTv()),
      expect: () => [
        TvWatchlistLoading(),
        TvWatchlistLoaded(testTvList),
      ],
      verify: (bloc) => verify(mockGetWatchlistTv.execute()),
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      "Should emit [Loading, Error] when get watchlist tv is unsuccessful",
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Server Failure")));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTv()),
      expect: () => [
        TvWatchlistLoading(),
        const TvWatchlistError("Server Failure"),
      ],
      verify: (bloc) => verify(mockGetWatchlistTv.execute()),
    );
  });

  group("Save Watchlist Tv", () {
    blocTest<TvWatchlistBloc, TvWatchlistState>(
      "Should emit [Loading, HasData] when data is gotten successfully",
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer(
            (_) async => const Right(TvWatchlistBloc.messageAddedToWatchlist));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnSaveWatchlistTv(testTvDetail)),
      expect: () => [
        TvWatchlistLoading(),
        const TvWatchlistMessage(TvWatchlistBloc.messageAddedToWatchlist)
      ],
      verify: (bloc) => verify(mockSaveWatchlistTv.execute(testTvDetail)),
    );
    blocTest<TvWatchlistBloc, TvWatchlistState>(
      "Should emit [Loading, Error] when save movie is unsuccessful",
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => const Left(ServerFailure("Server Failure")));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnSaveWatchlistTv(testTvDetail)),
      expect: () => [
        TvWatchlistLoading(),
        const TvWatchlistError("Server Failure"),
      ],
      verify: (bloc) => verify(mockSaveWatchlistTv.execute(testTvDetail)),
    );
  });

  group("Remove Watchlist Tv", () {
    blocTest<TvWatchlistBloc, TvWatchlistState>(
      "Should emit [Loading, HasData] when data is gotten successfully",
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer(
            (_) async => const Right(TvWatchlistBloc.messageRemoveToWatchlist));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnRemoveWatchlistTv(testTvDetail)),
      expect: () => [
        TvWatchlistLoading(),
        const TvWatchlistMessage(TvWatchlistBloc.messageRemoveToWatchlist)
      ],
      verify: (bloc) => verify(mockRemoveWatchlistTv.execute(testTvDetail)),
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      "Should emit [Loading, Error] when remove movie is unsuccessful",
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => const Left(ServerFailure("Server Failure")));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnRemoveWatchlistTv(testTvDetail)),
      expect: () => [
        TvWatchlistLoading(),
        const TvWatchlistError("Server Failure"),
      ],
      verify: (bloc) => verify(mockRemoveWatchlistTv.execute(testTvDetail)),
    );
  });

  group("Load Watchlist Movie", () {
    blocTest<TvWatchlistBloc, TvWatchlistState>(
      "Should emit [Loading, Load(true)] when data is gotten successfully",
      build: () {
        when(mockGetWatchListStatusTv.execute(tId))
            .thenAnswer((realInvocation) async => true);
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnLoadWatchlistStatusTv(tId)),
      expect: () => [
        TvWatchlistLoading(),
        const TvLoadWatchlist(true),
      ],
      verify: (bloc) => verify(mockGetWatchListStatusTv.execute(tId)),
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      "Should emit [Loading, Load(false)] when remove movie is unsuccessful",
      build: () {
        when(mockGetWatchListStatusTv.execute(tId))
            .thenAnswer((realInvocation) async => false);
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnLoadWatchlistStatusTv(tId)),
      expect: () => [
        TvWatchlistLoading(),
        const TvLoadWatchlist(false),
      ],
    );
  });
}
