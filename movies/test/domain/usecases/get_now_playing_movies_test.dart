import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingMovies usecase;
  late MockMoviesRepository mockRepository;

  setUp(() {
    mockRepository = MockMoviesRepository();
    usecase = GetNowPlayingMovies(mockRepository);
  });

  final tMovies = <Movie>[];

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockRepository.getNowPlayingMovies())
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tMovies));
  });
}
