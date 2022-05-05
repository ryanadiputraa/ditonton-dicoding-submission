part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

// now playing movies
class WatchlistMoviesEmpty extends WatchlistMoviesState {}

class WatchlistMoviesLoading extends WatchlistMoviesState {}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class HasWatchlistMovies extends WatchlistMoviesState {
  final List<Movie> result;

  const HasWatchlistMovies(this.result);

  @override
  List<Object> get props => [result];
}

class IsMovieAddedToWatchlist extends WatchlistMoviesState {
  final bool isAdded;

  const IsMovieAddedToWatchlist(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class WatchlistMovieMessage extends WatchlistMoviesState {
  final String message;

  const WatchlistMovieMessage(this.message);

  @override
  List<Object> get props => [message];
}
