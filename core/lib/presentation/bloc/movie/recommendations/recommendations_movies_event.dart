part of 'recommendations_movies_bloc.dart';

abstract class RecommendationsMoviesEvent extends Equatable {
  const RecommendationsMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnGetRecommendationsMovies extends RecommendationsMoviesEvent {
  final int id;

  const OnGetRecommendationsMovies(this.id);

  @override
  List<Object> get props => [];
}
