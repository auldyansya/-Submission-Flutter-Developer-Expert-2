import '../../../../presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/movies/movies_top_rated_bloc/movies_top_rated_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top-rated-movie';

  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<MoviesTopRatedBloc>().add(FetchTopRatedMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviesTopRatedBloc, MoviesTopRatedState>(
          builder: (context, state) {
            if (state is MoviesTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviesTopRatedLoaded) {
              final result = state.result;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie : movie);
                },
                itemCount: result.length,
              );
            } else if (state is MoviesTopRatedError) {
              return Center(
                  key: const Key("Error Message"),
                  child: Text(state.message),
              );
            } else if (state is MoviesTopRatedEmpty) {
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
