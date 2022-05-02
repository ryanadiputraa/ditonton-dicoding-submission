part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnGetWatchlistMovies extends WatchlistMoviesEvent {
  OnGetWatchlistMovies();

  @override
  List<Object> get props => [];
}

class OnGetWatchlistStatus extends WatchlistMoviesEvent {
  final int id;

  OnGetWatchlistStatus(this.id);
}

class OnSaveWatchlistMovies extends WatchlistMoviesEvent {
  final MovieDetail movieDetail;

  OnSaveWatchlistMovies(this.movieDetail);

  @override
  List<Object> get props => [];
}

class OnRemoveWatchlistMovies extends WatchlistMoviesEvent {
  final MovieDetail movieDetail;

  OnRemoveWatchlistMovies(this.movieDetail);

  @override
  List<Object> get props => [];
}
