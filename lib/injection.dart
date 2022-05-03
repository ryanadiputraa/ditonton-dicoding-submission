import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv/tv_repository.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv/get_detail_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_ontheair_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/remove_watch_list.dart';
import 'package:ditonton/domain/usecases/tv/save_watch_list.dart';
import 'package:ditonton/domain/usecases/tv/search_tv.dart';
import 'package:ditonton/presentation/bloc/movie/moviedetail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/nowplaying/nowplaying_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recommendations/recommendations_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/toprated/toprated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/ontheair/ontheair_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/popular/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/recommendations/tv_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/toprated/toprated_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tvdetail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/provider/tv/tv_search_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

final locator = GetIt.instance;

void init() async {
  IOClient ioClient = await SSLPinning.ioClient;

  // bloc
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => RecommendationsMoviesBloc(locator()));
  locator.registerFactory(
      () => WatchlistMoviesBloc(locator(), locator(), locator(), locator()));

  locator.registerFactory(() => OnTheAirTvBloc(locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));
  locator.registerFactory(() => TvDetailBloc(locator()));
  locator.registerFactory(() => TvRecommendationsBloc(locator()));
  locator.registerFactory(
      () => WatchlistTvBloc(locator(), locator(), locator(), locator()));

  // provider
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetOnTheAirTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetDetailTv(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchList(locator()));
  locator.registerLazySingleton(() => RemoveWatchList(locator()));
  locator.registerLazySingleton(() => GetWatchListTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => ioClient);
}
