import 'package:movies/data/datasources/movies_local_data_source.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MoviesLocalDataSourceImpl dataSource;
  late MockMoviesDatabaseHelper mockMoviesDatabaseHelper;

  setUp(() {
    mockMoviesDatabaseHelper = MockMoviesDatabaseHelper();
    dataSource = MoviesLocalDataSourceImpl(databaseHelper: mockMoviesDatabaseHelper);
  });

  group('Save Watchlist Movies', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockMoviesDatabaseHelper.insertWatchlistMovies(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlistMovies(testMovieTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockMoviesDatabaseHelper.insertWatchlistMovies(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlistMovies(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove Watchlist Movies', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockMoviesDatabaseHelper.removeWatchlistMovies(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlistMovies(testMovieTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockMoviesDatabaseHelper.removeWatchlistMovies(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistMovies(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movies Detail By Id', () {
    const tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockMoviesDatabaseHelper.getMoviesById(tId))
          .thenAnswer((_) async => testMovieMap);
      // act
      final result = await dataSource.getMoviesById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockMoviesDatabaseHelper.getMoviesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMoviesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('Get Watchlist Movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockMoviesDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });
  });
}
