import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/bloc/movies/movies_detail_bloc/movies_detail_bloc.dart';
import 'package:movies/presentation/bloc/movies/movies_now_playing_bloc/movies_now_playing_bloc.dart';
import 'package:movies/presentation/bloc/movies/movies_popular_bloc/movies_popular_bloc.dart';
import 'package:movies/presentation/bloc/movies/movies_recommendations_bloc/movies_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/movies/movies_top_rated_bloc/movies_top_rated_bloc.dart';
import 'package:movies/presentation/bloc/movies/movies_watchlist_bloc/movie_watchlist_bloc.dart';

class MoviesDetailStateHelper extends Fake implements MoviesDetailState {}

class MoviesDetailEventHelper extends Fake implements MoviesDetailEvent {}

class MovieDetailBlocHelper
    extends MockBloc<MoviesDetailEvent, MoviesDetailState>
    implements MoviesDetailBloc {}

class MoviesRecommendationsStateHelper extends Fake
    implements MoviesRecommendationsState {}

class MoviesRecommendationsEventHelper extends Fake
    implements MoviesRecommendationsEvent {}

class MovieRecommendationsBlocHelper
    extends MockBloc<MoviesRecommendationsEvent, MoviesRecommendationsState>
    implements MoviesRecommendationsBloc {}

class MoviesWatchlistStateHelper extends Fake implements MovieWatchlistState {}

class MoviesWatchlistEventHelper extends Fake implements MovieWatchlistEvent {}

class MovieWatchlistBlocHelper
    extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}

class MoviesNowPlayingStateHelper extends Fake
    implements MoviesNowPlayingState {}

class MoviesNowPlayingEventHelper extends Fake
    implements MoviesNowPlayingEvent {}

class MoviesNowPlayingBlocHelper
    extends MockBloc<MoviesNowPlayingEvent, MoviesNowPlayingState>
    implements MoviesNowPlayingBloc {}

class MoviesTopRatedStateHelper extends Fake implements MoviesTopRatedState {}

class MoviesTopRatedEventHelper extends Fake implements MoviesTopRatedEvent {}

class MoviesTopRatedBlocHelper
    extends MockBloc<MoviesTopRatedEvent, MoviesTopRatedState>
    implements MoviesTopRatedBloc {}

class MoviesPopularStateHelper extends Fake implements MoviesPopularState {}

class MoviesPopularEventHelper extends Fake implements MoviesPopularEvent {}

class MoviesPopularBlocHelper
    extends MockBloc<MoviesPopularEvent, MoviesPopularState>
    implements MoviesPopularBloc {}
