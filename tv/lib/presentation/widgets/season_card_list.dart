import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';


import '../../domain/entities/season.dart';

import 'package:core/core.dart';

class SeasonCard extends StatelessWidget {
  final Season season;

  const SeasonCard({Key? key, required this.season}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Card(
            child: Container(
              margin: const EdgeInsets.only(
                left: 16 + 80 + 16,
                bottom: 8,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    season.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6,
                  ),
                  Row(
                    children: [
                      Text(
                        FormatDate.formatDateYear(season.airDate),
                      ),
                      const Text(
                        ' | ',
                      ),
                      Text(
                        '${season.episodeCount} Episode',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    season.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              bottom: 16,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
                width: 80,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => const Center(
                    child: SizedBox(
                        width: 80, height: 80, child: Icon(Icons.error))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
