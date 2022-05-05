part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnGetWatchlistMovies extends WatchlistMoviesEvent {
  const OnGetWatchlistMovies();

  @override
  List<Object> get props => [];
}

class OnGetWatchlistStatus extends WatchlistMoviesEvent {
  final int id;

  const OnGetWatchlistStatus(this.id);
}

class OnSaveWatchlistMovies extends WatchlistMoviesEvent {
  final MovieDetail movieDetail;

  const OnSaveWatchlistMovies(this.movieDetail);

  @override
  List<Object> get props => [];
}

class OnRemoveWatchlistMovies extends WatchlistMoviesEvent {
  final MovieDetail movieDetail;

  const OnRemoveWatchlistMovies(this.movieDetail);

  @override
  List<Object> get props => [];
}
