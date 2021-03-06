import 'package:core/domain/entities/movie/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecase/get_movie_recommendations.dart';

part 'recommendations_movies_event.dart';
part 'recommendations_movies_state.dart';

class RecommendationsMoviesBloc
    extends Bloc<RecommendationsMoviesEvent, RecommendationsMoviesState> {
  final GetMovieRecommendations _getRecommendationsMovies;

  RecommendationsMoviesBloc(this._getRecommendationsMovies)
      : super(RecommendationsEmpty()) {
    on<OnGetRecommendationsMovies>((event, emit) async {
      final id = event.id;

      emit(RecommendationsLoading());
      final result = await _getRecommendationsMovies.execute(id);

      result.fold(
        (failure) {
          emit(RecommendationsError(failure.message));
        },
        (data) {
          emit(HasRecommendationsMovies(data));
        },
      );
    });
  }
}
