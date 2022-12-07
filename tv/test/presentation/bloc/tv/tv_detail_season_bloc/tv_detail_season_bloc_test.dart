import 'package:dartz/dartz.dart';
import 'package:tv/domain/usecases/get_tv_season_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/presentation/bloc/tv/tv_season_detail_bloc/tv_season_detail_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_detail_season_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeasonDetail])
void main() {
  late TvSeasonDetailBloc tvSeasonDetailBloc;
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;

  setUp(() {
    mockGetTvSeasonDetail = MockGetTvSeasonDetail();
    tvSeasonDetailBloc = TvSeasonDetailBloc(mockGetTvSeasonDetail);
  });

  const tId = 1;
  const tSeason = 1;

  test('initial state should be empty', () {
    expect(tvSeasonDetailBloc.state, TvSeasonDetailEmpty());
  });

  blocTest<TvSeasonDetailBloc, TvSeasonDetailState>(
    "Should emit [Loading, Loaded] when data is gotten successfully",
    build: () {
      when(mockGetTvSeasonDetail.execute(tId, tSeason))
          .thenAnswer((_) async => const Right(testTvSeasonDetail));
      return tvSeasonDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchSeasonDetailTv(tId, tSeason)),
    expect: () => [
      TvSeasonDetailLoading(),
      TvSeasonDetailLoaded(testTvSeasonDetail),
    ],
    verify: (bloc) => verify(mockGetTvSeasonDetail.execute(tId, tSeason)),
  );

  blocTest<TvSeasonDetailBloc, TvSeasonDetailState>(
    "Should emit [Loading, Error] when get detail movie is unsuccessful",
    build: () {
      when(mockGetTvSeasonDetail.execute(tId, tSeason))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeasonDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchSeasonDetailTv(tId, tSeason)),
    expect: () => [
      TvSeasonDetailLoading(),
      TvSeasonDetailError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetTvSeasonDetail.execute(tId, tSeason)),
  );
}
