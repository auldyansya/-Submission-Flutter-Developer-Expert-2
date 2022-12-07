import 'episode_model.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_season_detail.dart';

class TvSeasonDetailResponse extends Equatable {
  const TvSeasonDetailResponse({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonsModelId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String? id;
  final String? airDate;
  final List<EpisodeModel> episodes;
  final String? name;
  final String? overview;
  final int? seasonsModelId;
  final String? posterPath;
  final int? seasonNumber;

  factory TvSeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeasonDetailResponse(
        id: json["_id"],
        airDate: json["air_date"],
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        seasonsModelId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date": airDate,
        "episodes": List<dynamic>.from(episodes.map((x) => x)),
        "name": name,
        "overview": overview,
        "id": seasonsModelId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  TvSeasonDetail toEntity() {
    return TvSeasonDetail(
      id: id ?? '',
      airDate: airDate ?? '',
      episodes: episodes.map((episode) => episode.toEntity()).toList(),
      name: name ?? '',
      overview: overview ?? '',
      seasonsModelId: seasonsModelId ?? 0,
      posterPath: posterPath ?? '',
      seasonNumber: seasonNumber ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        seasonsModelId,
        posterPath,
        seasonNumber,
      ];
}
