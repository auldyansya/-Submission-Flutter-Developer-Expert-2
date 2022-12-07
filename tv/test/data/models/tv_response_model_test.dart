import 'dart:convert';

import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvModel = TvModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalname',
    overview: 'overview',
    popularity: 1,
    posterPath: 'poster_path',
    firstAirDate: 'first_air_date',
    name: 'name',
    originalLanguage:  'original_language',
    voteAverage: 1,
    voteCount: 1,
  );
  const tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdropPath": "backdropPath",
            "genreIds": [1, 2, 3],
            "id": 1,
            "original_name": "originalname",
            "overview": "overview",
            "popularity": 1,
            "poster_path": "poster_path",
            "first_air_date": "first_air_date",
            "name": "name",
            "original_language": "original_language",
            "vote_average": 1,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
