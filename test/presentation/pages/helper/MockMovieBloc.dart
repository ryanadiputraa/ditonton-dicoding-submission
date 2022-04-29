import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/popular/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/toprated/toprated_movies_bloc.dart';
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
