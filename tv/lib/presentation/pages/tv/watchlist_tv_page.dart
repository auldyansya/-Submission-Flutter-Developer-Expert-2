import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../bloc/tv/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import '../../widgets/tv_card_list.dart';

import 'package:core/core.dart';

class WatchlistTvPage extends StatefulWidget {
  static const routeName = '/watchlist-tv';

  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context
            .read<TvWatchlistBloc>()
            .add(FetchWatchlistTv()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context
        .read<TvWatchlistBloc>()
        .add(FetchWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
          builder: (context, state) {
            if (state is TvWatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvWatchlistLoaded) {
              final result = state.watchlist;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv: tv);
                },
                itemCount: result.length,
              );
            } else if (state is TvWatchlistError) {
              return Center(child: Text(state.message));
            } else if (state is TvWatchlistEmpty) {
              return Center(
                child: Column(children: [
                  Lottie.asset('assets/nodatawatchlist.json'),
                  Text(
                    'No Data',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.withOpacity(0.2),
                        fontSize: 20),
                  ),
                ]),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
