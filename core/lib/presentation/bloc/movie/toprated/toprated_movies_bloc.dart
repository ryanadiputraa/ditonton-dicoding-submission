import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'toprated_movies_event.dart';
part 'toprated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(TopRatedEmpty()) {
    on<OnGetTopRatedMovies>((event, emit) async {
      emit(TopRatedLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(TopRatedError(failure.message));
        },
        (data) {
          emit(HasTopRatedMovies(data));
        },
      );
    });
  }
}
