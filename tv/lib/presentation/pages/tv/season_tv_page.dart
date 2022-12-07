import '../../../../domain/entities/tv_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../bloc/tv/tv_detail_bloc/tv_detail_bloc.dart';
import '../../widgets/season_card_list.dart';

import 'package:core/core.dart';

class SeasonTvPage extends StatefulWidget {
  static const routeName = '/season-tv';
  final int id;

  const SeasonTvPage({Key? key, required this.id}) : super(key: key);

  @override
  State<SeasonTvPage> createState() => _SeasonTvPageState();
}

class _SeasonTvPageState extends State<SeasonTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(FetchDetailTv(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
          builder: (context, state) {
            if (state is TvDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvDetailLoaded) {
              final result = state.result;
              return SafeArea(
                child: DetailContentTv(
                  tv: result,
                ),
              );
            } else if (state is TvDetailError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          }),
    );
  }
}

class DetailContentTv extends StatelessWidget {
  final TvDetail tv;

  const DetailContentTv({Key? key, required this.tv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(tv.name),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: tv.seasons.length,
            itemBuilder: (context, i) {
              var season = tv.seasons[i];
              return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, episodeTvRoute,
                        arguments: {
                          'id': tv.id,
                          'season': season.seasonNumber,
                        });
                  },
                  child: SeasonCard(season: season));
            }));
  }
}
