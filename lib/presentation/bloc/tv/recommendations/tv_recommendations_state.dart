part of 'tv_recommendations_bloc.dart';

abstract class TvRecommendationsState extends Equatable {
  const TvRecommendationsState();

  @override
  List<Object> get props => [];
}

class TvRecommendationsEmpty extends TvRecommendationsState {}

class TvRecommendationsLoading extends TvRecommendationsState {}

class TvRecommendationsError extends TvRecommendationsState {
  final String message;

  TvRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class HasTvRecommendations extends TvRecommendationsState {
  final List<Tv> result;

  HasTvRecommendations(this.result);

  @override
  List<Object> get props => [result];
}
