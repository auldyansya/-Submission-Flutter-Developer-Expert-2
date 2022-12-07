import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tv/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import '../../widgets/tv_card_list.dart';

class TopRatedTvPage extends StatefulWidget {
  static const routeName = '/top-rated-tv';

  const TopRatedTvPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TvTopRatedBloc>().add(FetchTopRatedTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
          builder: (context, state) {
            if (state is TvTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvTopRatedLoaded) {
              final result = state.result;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv : tv);
                },
                itemCount: result.length,
              );
            } else if (state is TvTopRatedError) {
              return Center(
                key: const Key("Error Message"),
                child: Text(state.message),
              );
            } else if (state is TvTopRatedEmpty) {
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
