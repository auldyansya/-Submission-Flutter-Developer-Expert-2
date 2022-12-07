import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/presentation/bloc/tv/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late TvNowPlayingBloc tvNowPlayingBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    tvNowPlayingBloc = TvNowPlayingBloc(mockGetNowPlayingTv);
  });

  test('initial state should be empty', () {
    expect(tvNowPlayingBloc.state, TvNowPlayingEmpty());
  });

  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvNowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTv()),
    expect: () => [
      TvNowPlayingLoading(),
      TvNowPlayingLoaded(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
    },
  );

  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvNowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTv()),
    expect: () => [
      TvNowPlayingLoading(),
      TvNowPlayingError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
    },
  );
}
