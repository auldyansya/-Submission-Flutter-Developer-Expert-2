import 'package:movies/data/datasources/db/movies_database_helper.dart';
import 'package:movies/data/datasources/movies_local_data_source.dart';
import 'package:movies/data/datasources/movies_remote_data_source.dart';
import 'package:movies/domain/repositories/movies_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:core/core.dart';

@GenerateMocks([
  MoviesRepository,
  MoviesRemoteDataSource,
  MoviesLocalDataSource,
  MoviesDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<SSLPinningClient>(as: #MockSSLPinningClient)
])
void main() {}
