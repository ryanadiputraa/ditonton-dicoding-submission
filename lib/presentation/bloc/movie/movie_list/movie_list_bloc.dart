import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;

  MovieListBloc(this._getNowPlayingMovies, this._getPopularMovies,
      this._getTopRatedMovies)
      : super(NowPlayingEmpty()) {
    on<OnGetNowPlayingMovies>((event, emit) async {
      emit(NowPlayingLoading());
      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(NowPlayingError(failure.message));
        },
        (data) {
          emit(MovieListHasNowPlaying(data));
        },
      );
    });

    on<OnGetPopularMovies>((event, emit) async {
      emit(PopularLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(PopularError(failure.message));
        },
        (data) {
          emit(MovieListHasPopular(data));
        },
      );
    });

    on<OnGetTopRatedMovies>((event, emit) async {
      emit(TopRatedLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(TopRatedError(failure.message));
        },
        (data) {
          emit(MovieListHasTopRated(data));
        },
      );
    });
  }
}
