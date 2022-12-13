import 'package:cached_network_image/cached_network_image.dart';

import '../../../../domain/entities/genre.dart';
import '../../../../domain/entities/tv_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


import '../../../domain/entities/season.dart';
import '../../bloc/tv/tv_detail_bloc/tv_detail_bloc.dart';
import '../../bloc/tv/tv_recommendations_bloc/tv_recommendations_bloc.dart';
import '../../bloc/tv/tv_watchlist_bloc/tv_watchlist_bloc.dart';

import 'package:core/core.dart';

class TvDetailPage extends StatefulWidget {
  static const routeName = '/detail-tv';

  final int id;

  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(FetchDetailTv(widget.id));
      context
          .read<TvWatchlistBloc>()
          .add(OnLoadWatchlistStatusTv(widget.id));
      context
          .read<TvRecommendationsBloc>()
          .add(FetchRecommendationsTv(widget.id));

    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAddedToWatchlist = context.select<TvWatchlistBloc, bool>((bloc) {
      var state = bloc.state;
      if(state is TvLoadWatchlist) {
        return state.isWatchlist;
      }
      return false;
    });
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
          builder: (context, state) {
            if (state is TvDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvDetailLoaded) {
              final result = state.result;
              return SafeArea(
                child: DetailContentDetailTv(
                  tv : result,
                  isAddedWatchlist: isAddedToWatchlist,
                ),
              );
            } else if (state is TvDetailError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          }),
    );
  }
}

class DetailContentDetailTv extends StatelessWidget {
  final TvDetail tv;
  final bool isAddedWatchlist;

  const DetailContentDetailTv({Key? key, required this.tv, required this.isAddedWatchlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<TvWatchlistBloc>()
                                      .add(OnSaveWatchlistTv(tv));
                                } else {
                                  context.read<TvWatchlistBloc>().add(
                                      OnRemoveWatchlistTv(tv));
                                }

                                String message = "";
                                final state =
                                    BlocProvider.of<TvWatchlistBloc>(context)
                                        .state;
                                if (state is TvLoadWatchlist) {
                                  message = isAddedWatchlist
                                      ? TvWatchlistBloc.messageRemoveToWatchlist
                                      : TvWatchlistBloc.messageAddedToWatchlist;
                                } else {
                                  message = isAddedWatchlist == false
                                      ? TvWatchlistBloc.messageAddedToWatchlist
                                      : TvWatchlistBloc.messageRemoveToWatchlist;
                                }

                                if (message == TvWatchlistBloc.messageAddedToWatchlist ||
                                    message == TvWatchlistBloc.messageRemoveToWatchlist) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                      content: Text(message),
                                      duration: const Duration(
                                        milliseconds: 500,
                                      )));
                                  BlocProvider.of<TvWatchlistBloc>(context)
                                      .add(OnLoadWatchlistStatusTv(tv.id));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Last Season ',
                              style: kHeading6,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (context, i) {
                                  int count = tv.seasons.length;
                                  var season = tv.seasons[count - 1];
                                  return _showSeason(season);
                                }),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        seasonTvRoute,
                                        arguments: tv.id,
                                      );
                                    },
                                    child: const Text('View All Seasons'))),
                            const SizedBox(height: 8),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvRecommendationsBloc,
                                TvRecommendationsState>(
                                builder: (context, state) {
                                  if (state is TvRecommendationsLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is TvRecommendationsLoaded) {
                                    return SizedBox(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final tv = state.result[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  tvDetailRoute,
                                                  arguments: tv.id,
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                        child: SizedBox(
                                                            width: 100,
                                                            height: 100,
                                                            child:
                                                            CircularProgressIndicator()),
                                                      ),
                                                  errorWidget: (context, url,
                                                      error) =>
                                                      const Center(
                                                          child: SizedBox(
                                                              width: 100,
                                                              height: 100,
                                                              child: Icon(
                                                                  Icons.error))),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: state.result.length,
                                      ),
                                    );
                                  } else if (state is TvRecommendationsError) {
                                    return Center(child: Text(state.message));
                                  } else if (state is TvRecommendationsEmpty) {
                                    return const Center(
                                      child: Text('No Data'),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }
    if (result.isEmpty) {
      return result;
    }
    return result.substring(0, result.length - 2);
  }

  Widget _showSeason(Season seasons) {
    return Card(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w500${seasons.posterPath}',
                width: 100,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => const Center(
                    child: SizedBox(
                        width: 100, height: 100, child: Icon(Icons.error))),
              ),
            ),
            const SizedBox(width: 5.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Season ${seasons.seasonNumber}',
                    ),
                    Row(
                      children: [
                        Text(
                          FormatDate.formatDateYear(seasons.airDate),
                        ),
                        const Text(
                          ' | ',
                        ),
                        Text(
                          '${seasons.episodeCount} Episode',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      seasons.overview,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
