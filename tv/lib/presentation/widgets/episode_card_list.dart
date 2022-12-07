import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import '../../domain/entities/episode.dart';

import 'package:core/core.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  const EpisodeCard({Key? key, required this.episode}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {},
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
                    Row(
                      children: [
                        Text(
                          '${episode.episodeNumber.toString()}.',
                          style: kHeading6,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            episode.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kHeading6,
                          ),
                        ),
                      ],
                    ),
                    if (episode.airDate == '')
                      const Text('')
                    else
                      Text(FormatDate.formatDate(episode.airDate)),
                    const SizedBox(height: 16),
                    Text(
                      episode.overview,
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
                  imageUrl: 'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                  width: 80,
                  height: 67,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                        width: 80,
                        height: 67,
                        child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Center(
                      child: SizedBox(
                          width: 80, height: 67, child: Icon(Icons.error))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
