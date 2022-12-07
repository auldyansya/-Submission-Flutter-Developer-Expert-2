import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/bloc/tv/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_recommendations_bloc/tv_recommendations_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_watchlist_bloc/tv_watchlist_bloc.dart';

class TvDetailStateHelper extends Fake implements TvDetailState {}

class TvDetailEventHelper extends Fake implements TvDetailEvent {}

class TvDetailBlocHelper
    extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class TvRecommendationsStateHelper extends Fake
    implements TvRecommendationsState {}

class TvRecommendationsEventHelper extends Fake
    implements TvRecommendationsEvent {}

class TvRecommendationsBlocHelper
    extends MockBloc<TvRecommendationsEvent, TvRecommendationsState>
    implements TvRecommendationsBloc {}

class TvWatchlistStateHelper extends Fake implements TvWatchlistState {}

class TvWatchlistEventHelper extends Fake implements TvWatchlistEvent {}

class TvWatchlistBlocHelper
    extends MockBloc<TvWatchlistEvent, TvWatchlistState>
    implements TvWatchlistBloc {}

class TvNowPlayingStateHelper extends Fake
    implements TvNowPlayingState {}

class TvNowPlayingEventHelper extends Fake
    implements TvNowPlayingEvent {}

class TvNowPlayingBlocHelper
    extends MockBloc<TvNowPlayingEvent, TvNowPlayingState>
    implements TvNowPlayingBloc {}

class TvTopRatedStateHelper extends Fake implements TvTopRatedState {}

class TvTopRatedEventHelper extends Fake implements TvTopRatedEvent {}

class TvTopRatedBlocHelper
    extends MockBloc<TvTopRatedEvent, TvTopRatedState>
    implements TvTopRatedBloc {}

class TvPopularStateHelper extends Fake implements TvPopularState {}

class TvPopularEventHelper extends Fake implements TvPopularEvent {}

class TvPopularBlocHelper
    extends MockBloc<TvPopularEvent, TvPopularState>
    implements TvPopularBloc {}
