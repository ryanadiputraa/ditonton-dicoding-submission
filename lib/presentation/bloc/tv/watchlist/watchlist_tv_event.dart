part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class OnGetWatchlistTv extends WatchlistTvEvent {
  OnGetWatchlistTv();

  @override
  List<Object> get props => [];
}

class OnGetWatchlistStatus extends WatchlistTvEvent {
  final int id;

  OnGetWatchlistStatus(this.id);
}

class OnSaveWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  OnSaveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [];
}

class OnRemoveWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  OnRemoveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [];
}
