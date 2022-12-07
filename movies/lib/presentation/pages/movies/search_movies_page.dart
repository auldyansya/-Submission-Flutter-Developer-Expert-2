
import '../../../../presentation/bloc/movies/movies_search_bloc/movies_search_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/movie_card_list.dart';

import 'package:core/core.dart';

class SearchMoviesPage extends StatefulWidget {
  static const routeName = '/search-movies';

  const SearchMoviesPage({Key? key}) : super(key: key);

  @override
  State<SearchMoviesPage> createState() => _SearchMoviesPageState();
}

class _SearchMoviesPageState extends State<SearchMoviesPage> {

  @override
  void deactivate() {
    super.deactivate();
    Future.microtask(() =>
    context.read<MoviesSearchBloc>().add(ResetMoviesSearch()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (query) {
                  context.read<MoviesSearchBloc>().add(OnQueryMoviesChanged(query));
                },
                onSubmitted: (query) {
                  context.read<MoviesSearchBloc>().add(OnQueryMoviesChanged(query));
                },
                decoration: const InputDecoration(
                  hintText: 'Search Movies',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 16),
              Text(
                'Search Result',
                style: kHeading6,
              ),
              BlocBuilder<MoviesSearchBloc, MoviesSearchState>(
                builder: (context, state) {
                  if (state is MoviesSearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MoviesSearchLoaded) {
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
                  } else if (state is MoviesSearchError) {
                    return Center(child: Text(state.message));
                  } else if (state is MoviesSearchEmpty) {
                    return Center(
                      child: Lottie.asset('assets/nodatasearch.json'),
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
}
