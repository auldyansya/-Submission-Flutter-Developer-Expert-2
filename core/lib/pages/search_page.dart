import 'package:flutter/material.dart';

import 'package:movies/movies.dart';
import 'package:tv/tv.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Movies'),
                Tab(text: 'Tv Series'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              SearchMoviesPage(),
              SearchTvPage(),
            ],
          ),
        ),
      );
}
