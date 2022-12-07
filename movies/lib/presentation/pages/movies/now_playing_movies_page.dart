import '../../../../presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/movies/movies_now_playing_bloc/movies_now_playing_bloc.dart';

class NowPlayingMoviesPage extends StatefulWidget {
  static const routeName = '/now-playing-movie';

  const NowPlayingMoviesPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingMoviesPage> createState() => _NowPlayingMoviesPageState();
}

class _NowPlayingMoviesPageState extends State<NowPlayingMoviesPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      context.read<MoviesNowPlayingBloc>().add(FetchNowPlayingMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviesNowPlayingBloc, MoviesNowPlayingState>(
          builder: (context, state) {
            if (state is MoviesNowPlayingLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviesNowPlayingLoaded) {
              final result = state.result;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie: movie);
                },
                itemCount: result.length,
              );
            } else if (state is MoviesNowPlayingError) {
              return Center(
                  key: const Key("Error Message"),
                  child: Text(state.message),
              );
            } else if (state is MoviesNowPlayingEmpty) {
              return const Center(
                child: Text('No Data'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
