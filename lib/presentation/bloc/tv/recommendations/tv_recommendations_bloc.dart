import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_recommendations_event.dart';
part 'tv_recommendations_state.dart';

class TvRecommendationsBloc
    extends Bloc<TvRecommendationsEvent, TvRecommendationsState> {
  final GetTvRecommendations _getTvRecommendations;

  TvRecommendationsBloc(this._getTvRecommendations)
      : super(TvRecommendationsEmpty()) {
    on<OnGetTvRecommendations>((event, emit) async {
      final int id = event.id;
      emit(TvRecommendationsLoading());
      final result = await _getTvRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(TvRecommendationsError(failure.message));
        },
        (data) {
          emit(HasTvRecommendations(data));
        },
      );
    });
  }
}
