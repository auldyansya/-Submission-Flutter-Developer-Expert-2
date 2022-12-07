import '../../data/models/genre_model.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_detail.dart';

class MovieDetailResponse extends Equatable {
  const MovieDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final List<GenreModel> genres;
  final int? id;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final int? runtime;
  final String? title;
  final double? voteAverage;
  final int? voteCount;

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        runtime: json["runtime"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() =>
      {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "runtime": runtime,
        "title": title,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  MovieDetail toEntity() {
    return MovieDetail(
        adult: adult ?? false,
        backdropPath: backdropPath ?? '',
        genres: genres.map((genre) => genre.toEntity()).toList(),
        id: id ?? 0,
        originalTitle: originalTitle ?? '',
        overview: overview ?? '',
        posterPath: posterPath ?? '',
        releaseDate: releaseDate ?? '',
        runtime: runtime ?? 0,
        title: title ?? '',
        voteAverage: voteAverage ?? 0,
        voteCount: voteCount ?? 0,
    );
  }

  @override
  List<Object?> get props =>
      [
        adult,
        backdropPath,
        genres,
        id,
        originalTitle,
        overview,
        posterPath,
        releaseDate,
        runtime,
        title,
        voteAverage,
        voteCount,
      ];
}
