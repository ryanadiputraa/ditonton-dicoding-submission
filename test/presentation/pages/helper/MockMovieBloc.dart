import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/moviedetail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recommendations/recommendations_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/toprated/toprated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockPopularMoviesEvent extends Fake implements PopularMoviesEvent {}

class MockPopularMoviesState extends Fake implements PopularMoviesState {}

class MockPopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

class MockTopRatedMoviesEvent extends Fake implements TopRatedMoviesEvent {}

class MockTopRatedMoviesState extends Fake implements TopRatedMoviesState {}

class MockTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

class MockMovieDetailEvent extends Fake implements MovieDetailEvent {}

class MockMovieDetailState extends Fake implements MovieDetailState {}

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MockMovieRecommendationsEvent extends Fake
    implements RecommendationsMoviesEvent {}

class MockMovieRecommendationsState extends Fake
    implements RecommendationsMoviesState {}

class MockMovieRecommendationsBloc
    extends MockBloc<RecommendationsMoviesEvent, RecommendationsMoviesState>
    implements RecommendationsMoviesBloc {}

class MockWatchlistMoviesEvent extends Fake implements WatchlistMoviesEvent {}

class MockWatchlistMoviesState extends Fake implements WatchlistMoviesState {}

class MockWatchlistMoviesBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}
