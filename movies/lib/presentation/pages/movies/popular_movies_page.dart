import '../../../../presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/movies/movies_popular_bloc/movies_popular_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const routeName = '/popular-movie';

  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MoviesPopularBloc>().add(FetchPopularMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviesPopularBloc, MoviesPopularState>(
          builder: (context, state) {
            if (state is MoviesPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviesPopularLoaded) {
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
            } else if (state is MoviesPopularError) {
              return Center(
                key: const Key('Error Message'),
                child: Text(state.message),
              );
            } else if (state is MoviesPopularEmpty) {
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
