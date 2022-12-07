import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/tv_season_detail.dart';
import '../../bloc/tv/tv_season_detail_bloc/tv_season_detail_bloc.dart';
import '../../widgets/episode_card_list.dart';

class EpisodeTvPage extends StatefulWidget {
  static const routeName = '/episode-tv';
  final int id;
  final int season;

  const EpisodeTvPage({Key? key, required this.id, required this.season}) : super(key: key);

  @override
  State<EpisodeTvPage> createState() => _EpisodeTvPageState();
}

class _EpisodeTvPageState extends State<EpisodeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<TvSeasonDetailBloc>()
          .add(FetchSeasonDetailTv(widget.id, widget.season));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeasonDetailBloc, TvSeasonDetailState>(
          builder: (context, state) {
        if (state is TvSeasonDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvSeasonDetailLoaded) {
          final result = state.result;
          return SafeArea(
            child: DetailContentEpisodeTv(
              tv : result,
            ),
          );
        } else if (state is TvSeasonDetailError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      }),
    );
  }
}

class DetailContentEpisodeTv extends StatelessWidget {
  final TvSeasonDetail tv;

  const DetailContentEpisodeTv({Key? key, required this.tv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(tv.name),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: tv.episodes.length,
            itemBuilder: (context, i) {
              var season = tv.episodes[i];
              return EpisodeCard(episode: season);
            }));
  }
}
