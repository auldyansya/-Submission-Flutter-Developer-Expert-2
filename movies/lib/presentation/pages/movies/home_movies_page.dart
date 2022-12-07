import 'package:cached_network_image/cached_network_image.dart';
import '../../../../domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/movies/movies_now_playing_bloc/movies_now_playing_bloc.dart';
import '../../bloc/movies/movies_popular_bloc/movies_popular_bloc.dart';
import '../../bloc/movies/movies_top_rated_bloc/movies_top_rated_bloc.dart';

import 'package:core/core.dart';

class HomeMoviesPage extends StatefulWidget {
  static const routeName = '/home-movie-page';

  const HomeMoviesPage({Key? key}) : super(key: key);

  @override
  State<HomeMoviesPage> createState() => _HomeMoviesPageState();
}

class _HomeMoviesPageState extends State<HomeMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MoviesNowPlayingBloc>().add(FetchNowPlayingMovies());
      context.read<MoviesPopularBloc>().add(FetchPopularMovies());
      context.read<MoviesTopRatedBloc>().add(FetchTopRatedMovies());
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
              accountName: Text(
                'Aulansah TV',
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                'aulansah@gmail.com',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(color: logoBlue),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, homeTvRoute);
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
        title: const Text('Movies'),
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
                title: 'Now Playing Movies',
                onTap: () => Navigator.pushNamed(
                    context, nowPlayingMoviesRoute),
              ),
              BlocBuilder<MoviesNowPlayingBloc, MoviesNowPlayingState>(
                builder: (context, state) {
                  if (state is MoviesNowPlayingLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MoviesNowPlayingLoaded) {
                    return MovieList(state.result);
                  } else if (state is MoviesNowPlayingError) {
                    return Center(child: Text(state.message));
                  } else if (state is MoviesNowPlayingEmpty) {
                    return const Center(
                      child: Text('No Data'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular Movies',
                onTap: () =>
                    Navigator.pushNamed(context, popularMoviesRoute),
              ),
              BlocBuilder<MoviesPopularBloc, MoviesPopularState>(
                builder: (context, state) {
                  if (state is MoviesPopularLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MoviesPopularLoaded) {
                    return MovieList(state.result);
                  } else if (state is MoviesPopularError) {
                    return Center(child: Text(state.message));
                  } else if (state is MoviesPopularEmpty) {
                    return const Center(
                      child: Text('No Data'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated Movies',
                onTap: () =>
                    Navigator.pushNamed(context, topRatedMoviesRoute),
              ),
              BlocBuilder<MoviesTopRatedBloc, MoviesTopRatedState>(
                builder: (context, state) {
                  if (state is MoviesTopRatedLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MoviesTopRatedLoaded) {
                    return MovieList(state.result);
                  } else if (state is MoviesTopRatedError) {
                    return Center(child: Text(state.message));
                  } else if (state is MoviesTopRatedEmpty) {
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

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  movieDetailRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
