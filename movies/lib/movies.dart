library movies;

export 'data/datasources/db/movies_database_helper.dart';
export 'data/datasources/movies_local_data_source.dart';
export 'data/datasources/movies_remote_data_source.dart';

export 'data/models/movie_detail_model.dart';
export 'data/models/movie_model.dart';
export 'data/models/movie_response.dart';
export 'data/models/movie_table.dart';
export 'data/models/genre_model.dart';

export 'data/repositories/movies_repository_impl.dart';

export 'domain/entities/genre.dart';
export 'domain/entities/movie.dart';
export 'domain/entities/movie_detail.dart';

export 'domain/repositories/movies_repository.dart';

export 'domain/usecases/get_movie_detail.dart';
export 'domain/usecases/get_movie_recommendations.dart';
export 'domain/usecases/get_now_playing_movies.dart';
export 'domain/usecases/get_popular_movies.dart';
export 'domain/usecases/get_top_rated_movies.dart';
export 'domain/usecases/get_movie_detail.dart';
export 'domain/usecases/get_watchlist_movies.dart';
export 'domain/usecases/get_watchlist_status_movies.dart';
export 'domain/usecases/remove_watchlist_movies.dart';
export 'domain/usecases/save_watchlist_movies.dart';
export 'domain/usecases/search_movies.dart';

export 'presentation/pages/movies/home_movies_page.dart';
export 'presentation/pages/movies/movies_detail_page.dart';
export 'presentation/pages/movies/now_playing_movies_page.dart';
export 'presentation/pages/movies/popular_movies_page.dart';
export 'presentation/pages/movies/search_movies_page.dart';
export 'presentation/pages/movies/top_rated_movies_page.dart';
export 'presentation/pages/movies/watchlist_movies_page.dart';

export 'presentation/bloc/movies/movies_detail_bloc/movies_detail_bloc.dart';
export 'presentation/bloc/movies/movies_now_playing_bloc/movies_now_playing_bloc.dart';
export 'presentation/bloc/movies/movies_popular_bloc/movies_popular_bloc.dart';
export 'presentation/bloc/movies/movies_recommendations_bloc/movies_recommendations_bloc.dart';
export 'presentation/bloc/movies/movies_search_bloc/movies_search_bloc.dart';
export 'presentation/bloc/movies/movies_top_rated_bloc/movies_top_rated_bloc.dart';
export 'presentation/bloc/movies/movies_watchlist_bloc/movie_watchlist_bloc.dart';

export 'presentation/widgets/movie_card_list.dart';