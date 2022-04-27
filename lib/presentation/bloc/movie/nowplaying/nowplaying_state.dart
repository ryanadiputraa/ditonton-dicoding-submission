part of 'nowplaying_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

// now playing movies
class NowPlayingEmpty extends NowPlayingMoviesState {}

class NowPlayingLoading extends NowPlayingMoviesState {}

class NowPlayingError extends NowPlayingMoviesState {
  final String message;

  NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class HasNowPlayingMovies extends NowPlayingMoviesState {
  final List<Movie> result;

  HasNowPlayingMovies(this.result);

  @override
  List<Object> get props => [result];
}

// popular movies