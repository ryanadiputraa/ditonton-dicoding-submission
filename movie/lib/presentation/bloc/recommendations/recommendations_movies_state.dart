part of 'recommendations_movies_bloc.dart';

abstract class RecommendationsMoviesState extends Equatable {
  const RecommendationsMoviesState();

  @override
  List<Object> get props => [];
}

// now playing movies
class RecommendationsEmpty extends RecommendationsMoviesState {}

class RecommendationsLoading extends RecommendationsMoviesState {}

class RecommendationsError extends RecommendationsMoviesState {
  final String message;

  const RecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class HasRecommendationsMovies extends RecommendationsMoviesState {
  final List<Movie> result;

  const HasRecommendationsMovies(this.result);

  @override
  List<Object> get props => [result];
}
