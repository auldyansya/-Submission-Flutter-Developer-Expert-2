
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/tv/tv_search_bloc/tv_search_bloc.dart';
import '../../widgets/tv_card_list.dart';

import 'package:core/core.dart';

class SearchTvPage extends StatelessWidget {
  static const routeName = '/search-tv';

  const SearchTvPage({Key? key}) : super(key: key);

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
                  context.read<TvSearchBloc>().add(OnQueryTvChanged(query));
                },
                onSubmitted: (query) {
                  context.read<TvSearchBloc>().add(OnQueryTvChanged(query));
                },
                decoration: const InputDecoration(
                  hintText: 'Search Tv Series',
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
              BlocBuilder<TvSearchBloc, TvSearchState>(
                builder: (context, state) {
                  if (state is TvSearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvSearchLoaded) {
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
                  } else if (state is TvSearchError) {
                    return Center(child: Text(state.message));
                  } else if (state is TvSearchEmpty) {
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
