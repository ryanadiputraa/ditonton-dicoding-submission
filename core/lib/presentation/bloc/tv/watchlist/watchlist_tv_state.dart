part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvEmpty extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvError extends WatchlistTvState {
  final String message;

  WatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

class HasWatchlistTv extends WatchlistTvState {
  final List<Tv> result;

  HasWatchlistTv(this.result);

  @override
  List<Object> get props => [result];
}

class IsTvAddedToWatchlist extends WatchlistTvState {
  final bool isAdded;

  IsTvAddedToWatchlist(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class WatchlistTvMessage extends WatchlistTvState {
  final String message;

  WatchlistTvMessage(this.message);

  @override
  List<Object> get props => [message];
}
