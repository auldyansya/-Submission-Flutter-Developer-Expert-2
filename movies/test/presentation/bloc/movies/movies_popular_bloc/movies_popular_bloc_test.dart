import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/presentation/bloc/movies/movies_popular_bloc/movies_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movies_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MoviesPopularBloc moviesPopularBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviesPopularBloc = MoviesPopularBloc(mockGetPopularMovies);
  });

  test('initial state should be empty', () {
    expect(moviesPopularBloc.state, MoviesPopularEmpty());
  });

  blocTest<MoviesPopularBloc, MoviesPopularState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return moviesPopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      MoviesPopularLoading(),
      MoviesPopularLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<MoviesPopularBloc, MoviesPopularState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviesPopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      MoviesPopularLoading(),
      MoviesPopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
