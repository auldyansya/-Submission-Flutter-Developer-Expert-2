import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Tv extends Equatable {
  Tv({
    required this.backdropPath,
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
    required this.voteCount
  });

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name
  });

  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int id;
  String? originalName;
  String? name;
  String? originalLanguage;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
    backdropPath,
    firstAirDate,
    genreIds,
    id,
    originalName,
    name,
    originalLanguage,
    overview,
    popularity,
    posterPath,
    voteAverage,
    voteCount,
  ];
}
