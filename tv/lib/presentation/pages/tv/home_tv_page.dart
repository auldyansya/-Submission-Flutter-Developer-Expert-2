import 'package:cached_network_image/cached_network_image.dart';

import '../../../../domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tv/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import '../../bloc/tv/tv_popular_bloc/tv_popular_bloc.dart';
import '../../bloc/tv/tv_top_rated_bloc/tv_top_rated_bloc.dart';

import 'package:core/core.dart';



class HomeTvPage extends StatefulWidget {
  static const routeName = '/home-tv-page';

  const HomeTvPage({super.key});

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvNowPlayingBloc>().add(FetchNowPlayingTv());
      context.read<TvPopularBloc>().add(FetchPopularTv());
      context.read<TvTopRatedBloc>().add(FetchTopRatedTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: logoBlue,
                backgroundImage: AssetImage('assets/aulansah.png'),
              ),
              accountName: Text('Aulansah TV', style: TextStyle(color: Colors.white),),
              accountEmail: Text('aulansah@gmail.com', style: TextStyle(color: Colors.white),),
              decoration: BoxDecoration(
                  color: logoBlue
              ),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, homeMovieRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Tv Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, watchlistRoute);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, aboutRoute);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing Tv Series',
                onTap: () =>
                    Navigator.pushNamed(context, nowPlayingTvRoute),
              ),
              BlocBuilder<TvNowPlayingBloc, TvNowPlayingState>(
                builder: (context, state) {
                  if (state is TvNowPlayingLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvNowPlayingLoaded) {
                    return TvList(state.result);
                  } else if (state is TvNowPlayingError) {
                    return Center(child: Text(state.message));
                  } else if (state is TvNowPlayingEmpty) {
                    return const Center(
                      child: Text('No Data'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular Tv Series',
                onTap: () =>
                    Navigator.pushNamed(context, popularTvRoute),
              ),
              BlocBuilder<TvPopularBloc, TvPopularState>(
                builder: (context, state) {
                  if (state is TvPopularLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvPopularLoaded) {
                    return TvList(state.result);
                  } else if (state is TvPopularError) {
                    return Center(child: Text(state.message));
                  } else if (state is TvPopularEmpty) {
                    return const Center(
                      child: Text('No Data'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated Tv Series',
                onTap: () =>
                    Navigator.pushNamed(context, topRatedTvRoute),
              ),
              BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
                builder: (context, state) {
                  if (state is TvTopRatedLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvTopRatedLoaded) {
                    return TvList(state.result);
                  } else if (state is TvTopRatedError) {
                    return Center(child: Text(state.message));
                  } else if (state is TvTopRatedEmpty) {
                    return const Center(
                      child: Text('No Data'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: kHeading6,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tv;

  const TvList(this.tv, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  tvDetailRoute,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
