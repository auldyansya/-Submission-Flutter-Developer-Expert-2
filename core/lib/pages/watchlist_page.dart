import 'package:flutter/material.dart';

import 'package:movies/movies.dart';
import 'package:tv/tv.dart';

class WatchlistPage extends StatelessWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('WatchList'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Movies'),
                Tab(text: 'Tv Series'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              WatchlistMoviesPage(),
              WatchlistTvPage(),
            ],
          ),
        ),
      );
}
