import '../../data/models/genre_model.dart';
import 'season_model.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_detail.dart';

class TvDetailResponse extends Equatable {
  const TvDetailResponse(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genres,
      required this.id,
      required this.originalName,
      required this.name,
      required this.originalLanguage,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.seasons,
      required this.voteAverage,
      required this.voteCount});

  final String? backdropPath;
  final String? firstAirDate;
  final List<GenreModel> genres;
  final int? id;
  final String? originalName;
  final String? name;
  final String? originalLanguage;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<SeasonModel> seasons;
  final double? voteAverage;
  final int? voteCount;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        firstAirDate: json["first_air_date"],
        name: json["name"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        posterPath: json["poster_path"],
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "id": id,
        "overview": overview,
        "popularity": popularity,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "first_air_date": firstAirDate,
        "name": name,
        "original_language": originalLanguage,
        "original_name": originalName,
        "seasons": List<dynamic>.from(seasons.map((x) => x)),
        "poster_path": posterPath,
      };

  TvDetail toEntity() {
    return TvDetail(
      backdropPath: backdropPath ?? '',
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id ?? 0,
      overview: overview ?? '',
      popularity: popularity ?? 0,
      voteAverage: voteAverage ?? 0,
      voteCount: voteCount ?? 0,
      posterPath: posterPath ?? '',
      originalName: originalName ?? '',
      originalLanguage: originalLanguage ?? '',
      name: name ?? '',
      seasons: seasons.map((season) => season.toEntity()).toList(),
      firstAirDate: firstAirDate ?? '',
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        overview,
        popularity,
        voteAverage,
        voteCount,
        firstAirDate,
        name,
        originalLanguage,
        posterPath,
        originalName,
        seasons,
      ];
}
