import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(PopularEmpty()) {
    on<OnGetPopularMovies>((event, emit) async {
      emit(PopularLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(PopularError(failure.message));
        },
        (data) {
          emit(HasPopularMovies(data));
        },
      );
    });
  }
}
