part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

// now playing movies
class PopularEmpty extends PopularMoviesState {}

class PopularLoading extends PopularMoviesState {}

class PopularError extends PopularMoviesState {
  final String message;

  const PopularError(this.message);

  @override
  List<Object> get props => [message];
}

class HasPopularMovies extends PopularMoviesState {
  final List<Movie> result;

  const HasPopularMovies(this.result);

  @override
  List<Object> get props => [result];
}

// popular movies