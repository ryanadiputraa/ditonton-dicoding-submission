part of 'tv_recommendations_bloc.dart';

abstract class TvRecommendationsEvent extends Equatable {
  const TvRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class OnGetTvRecommendations extends TvRecommendationsEvent {
  final int id;

  OnGetTvRecommendations(this.id);

  @override
  List<Object> get props => [];
}
