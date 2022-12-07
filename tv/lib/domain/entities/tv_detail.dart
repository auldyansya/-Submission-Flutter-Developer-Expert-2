import '../../domain/entities/genre.dart';
import '../../domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  const TvDetail({
    required this.backdropPath,
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
    required this.voteCount
  });

  final String backdropPath;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final String name;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<Season> seasons;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
    backdropPath,
    firstAirDate,
    genres,
    id,
    originalName,
    name,
    originalLanguage,
    overview,
    popularity,
    posterPath,
    seasons,
    voteAverage,
    voteCount
  ];
}
