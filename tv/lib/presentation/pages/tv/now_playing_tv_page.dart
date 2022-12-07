import '../../widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tv/tv_now_playing_bloc/tv_now_playing_bloc.dart';

class NowPlayingTvPage extends StatefulWidget {
  static const routeName = '/now-playing-tv';

  const NowPlayingTvPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingTvPage> createState() => _NowPlayingTvPageState();
}

class _NowPlayingTvPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TvNowPlayingBloc>().add(FetchNowPlayingTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvNowPlayingBloc, TvNowPlayingState>(
          builder: (context, state) {
            if (state is TvNowPlayingLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvNowPlayingLoaded) {
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
            } else if (state is TvNowPlayingError) {
              return Center(
                  key: const Key('Error Message'),
                  child: Text(state.message));
            } else if (state is TvNowPlayingEmpty) {
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
