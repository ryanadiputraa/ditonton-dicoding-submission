part of 'toprated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

// now playing movies
class TopRatedEmpty extends TopRatedMoviesState {}

class TopRatedLoading extends TopRatedMoviesState {}

class TopRatedError extends TopRatedMoviesState {
  final String message;

  TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class HasTopRatedMovies extends TopRatedMoviesState {
  final List<Movie> result;

  HasTopRatedMovies(this.result);

  @override
  List<Object> get props => [result];
}
