import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:movies/presentation/bloc/movies/movies_search_bloc/movies_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movies_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MoviesSearchBloc moviesSearchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    moviesSearchBloc = MoviesSearchBloc(mockSearchMovies);
  });

  const tQuery = 'spiderman';

  test('initial state should be empty', () {
    expect(moviesSearchBloc.state, MoviesSearchEmpty());
  });

  blocTest<MoviesSearchBloc, MoviesSearchState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(testMovieList));
      return moviesSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryMoviesChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MoviesSearchLoading(),
      MoviesSearchLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<MoviesSearchBloc, MoviesSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviesSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryMoviesChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MoviesSearchLoading(),
      MoviesSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
