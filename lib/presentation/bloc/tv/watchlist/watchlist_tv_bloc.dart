import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/remove_watch_list.dart';
import 'package:ditonton/domain/usecases/tv/save_watch_list.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchListTv _getWatchlistTv;
  final GetWatchlistStatus _getWatchListStatus;
  final SaveWatchList _saveWatchlist;
  final RemoveWatchList _removeWatchlist;

  WatchlistTvBloc(this._getWatchlistTv, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistTvEmpty()) {
    on<OnGetWatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await _getWatchlistTv.execute();

      result.fold(
        (failure) {
          emit(WatchlistTvError(failure.message));
        },
        (data) {
          emit(HasWatchlistTv(data));
        },
      );
    });

    on<OnGetWatchlistStatus>((event, emit) async {
      final int id = event.id;
      final result = await _getWatchListStatus.execute(id);
      emit(IsTvAddedToWatchlist(result));
    });

    on<OnSaveWatchlistTv>((event, emit) async {
      final movieDetail = event.tvDetail;

      final result = await _saveWatchlist.execute(movieDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvError(failure.message));
        },
        (data) {
          emit(WatchlistTvMessage(data));
        },
      );
    });

    on<OnRemoveWatchlistTv>((event, emit) async {
      final movieDetail = event.tvDetail;

      final result = await _removeWatchlist.execute(movieDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvError(failure.message));
        },
        (data) {
          emit(WatchlistTvMessage(data));
        },
      );
    });
  }
}
