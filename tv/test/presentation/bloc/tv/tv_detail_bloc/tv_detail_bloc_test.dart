import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/presentation/bloc/tv/tv_detail_bloc/tv_detail_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  const tId = 1;

  test('initial state should be loading', () {
    expect(tvDetailBloc.state, TvDetailLoading());
  });

  blocTest<TvDetailBloc, TvDetailState>(
    "Should emit [Loading, Loaded] when data is gotten successfully",
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => const Right(testTvDetail));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailTv(tId)),
    expect: () => [
      TvDetailLoading(),
      TvDetailLoaded(testTvDetail),
    ],
    verify: (bloc) => verify(mockGetTvDetail.execute(tId)),
  );

  blocTest<TvDetailBloc, TvDetailState>(
    "Should emit [Loading, Error] when get detail movie is unsuccessful",
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailTv(tId)),
    expect: () => [
      TvDetailLoading(),
      TvDetailError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetTvDetail.execute(tId)),
  );
}
