import 'package:equatable/equatable.dart';

import '../../domain/entities/tv.dart';

class TvModel extends Equatable {
  const TvModel(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genreIds,
      required this.id,
      required this.originalName,
      required this.name,
      required this.originalLanguage,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount});

  final String? backdropPath;
  final String? firstAirDate;
  final List<int> genreIds;
  final int? id;
  final String? originalName;
  final String? name;
  final String? originalLanguage;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
      backdropPath: json["backdropPath"],
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"],
      overview: json["overview"],
      popularity: json["popularity"].toDouble(),
      voteAverage: json["vote_average"].toDouble(),
      voteCount: json["vote_count"],
      firstAirDate: json["first_air_date"],
      name: json["name"],
      originalLanguage: json["original_language"],
      originalName: json["original_name"],
      posterPath: json["poster_path"]);

  Map<String, dynamic> toJson() => {
        "backdropPath": backdropPath,
        "genreIds": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "overview": overview,
        "popularity": popularity,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "first_air_date": firstAirDate,
        "name": name,
        "original_language": originalLanguage,
        "original_name": originalName,
        "poster_path": posterPath,
      };

  Tv toEntity() {
    return Tv(
      backdropPath: backdropPath ?? '',
      genreIds: genreIds,
      id: id ?? 0,
      overview: overview ?? '',
      popularity: popularity ?? 0,
      voteAverage: voteAverage ?? 0,
      voteCount: voteCount ?? 0,
      posterPath: posterPath ?? '',
      originalName: originalName ?? '',
      originalLanguage: originalLanguage ?? '',
      name: name ?? '',
      firstAirDate: firstAirDate ?? '',
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
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
      ];
}
