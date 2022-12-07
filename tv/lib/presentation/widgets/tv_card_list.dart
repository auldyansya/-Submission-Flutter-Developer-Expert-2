import 'package:cached_network_image/cached_network_image.dart';

import '../../domain/entities/tv.dart';
import 'package:flutter/material.dart';

import '../pages/tv/tv_detail_page.dart';

import 'package:core/core.dart';

class TvCard extends StatelessWidget {
  final Tv tv;

  const TvCard({Key? key, required this.tv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            TvDetailPage.routeName,
            arguments: tv.id,
          );
        },
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
                      tv.name ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tv.overview ?? '-',
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
                  imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                  width: 80,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Center(
                      child: SizedBox(
                          width: 100, height: 100, child: Icon(Icons.error))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
