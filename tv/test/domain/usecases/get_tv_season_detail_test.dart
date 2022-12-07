import 'package:dartz/dartz.dart';
import 'package:tv/domain/usecases/get_tv_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeasonDetail usecase;
  late MockTvRepository mockRepository;

  setUp(() {
    mockRepository = MockTvRepository();
    usecase = GetTvSeasonDetail(mockRepository);
  });

  const tId = 1;
  const tSeason = 1;

  test('should get tv season detail from the repository', () async {
    // arrange
    when(mockRepository.getTvSeasonDetail(tId, tSeason))
        .thenAnswer((_) async => const Right(testTvSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeason);
    // assert
    expect(result, const Right(testTvSeasonDetail));
  });
}
