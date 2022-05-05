part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class OnGetWatchlistTv extends WatchlistTvEvent {
  const OnGetWatchlistTv();

  @override
  List<Object> get props => [];
}

class OnGetWatchlistTvStatus extends WatchlistTvEvent {
  final int id;

  const OnGetWatchlistTvStatus(this.id);
}

class OnSaveWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  const OnSaveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [];
}

class OnRemoveWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  const OnRemoveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [];
}
