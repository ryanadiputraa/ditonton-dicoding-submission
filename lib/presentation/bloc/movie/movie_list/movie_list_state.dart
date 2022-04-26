part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

// now playing movies
class NowPlayingEmpty extends MovieListState {}

class NowPlayingLoading extends MovieListState {}

class NowPlayingError extends MovieListState {
  final String message;

  NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieListHasNowPlaying extends MovieListState {
  final List<Movie> nowPlaying;

  MovieListHasNowPlaying(this.nowPlaying);

  @override
  List<Object> get props => [nowPlaying];
}

// popular movies
class PopularEmpty extends MovieListState {}

class PopularLoading extends MovieListState {}

class PopularError extends MovieListState {
  final String message;

  PopularError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieListHasPopular extends MovieListState {
  final List<Movie> popular;

  MovieListHasPopular(this.popular);

  @override
  List<Object> get props => [popular];
}

// top rated movies
class TopRatedEmpty extends MovieListState {}

class TopRatedLoading extends MovieListState {}

class TopRatedError extends MovieListState {
  final String message;

  TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieListHasTopRated extends MovieListState {
  final List<Movie> topRated;

  MovieListHasTopRated(this.topRated);

  @override
  List<Object> get props => [topRated];
}
