import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/entities/movie/movie_detail.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchlistMoviesBloc(this._getWatchlistMovies, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistMoviesEmpty()) {
    on<OnGetWatchlistMovies>((event, emit) async {
      emit(WatchlistMoviesLoading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(WatchlistMoviesError(failure.message));
        },
        (data) {
          emit(HasWatchlistMovies(data));
        },
      );
    });

    on<OnGetWatchlistStatus>((event, emit) async {
      final int id = event.id;
      final result = await _getWatchListStatus.execute(id);
      emit(IsMovieAddedToWatchlist(result));
    });

    on<OnSaveWatchlistMovies>((event, emit) async {
      final movieDetail = event.movieDetail;

      final result = await _saveWatchlist.execute(movieDetail);

      result.fold(
        (failure) {
          emit(WatchlistMoviesError(failure.message));
        },
        (data) {
          emit(WatchlistMovieMessage(data));
        },
      );
    });

    on<OnRemoveWatchlistMovies>((event, emit) async {
      final movieDetail = event.movieDetail;

      final result = await _removeWatchlist.execute(movieDetail);

      result.fold(
        (failure) {
          emit(WatchlistMoviesError(failure.message));
        },
        (data) {
          emit(WatchlistMovieMessage(data));
        },
      );
    });
  }
}
