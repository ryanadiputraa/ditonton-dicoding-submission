part of 'toprated_movies_bloc.dart';

abstract class TopRatedMoviesEvent extends Equatable {
  const TopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnGetTopRatedMovies extends TopRatedMoviesEvent {
  const OnGetTopRatedMovies();

  @override
  List<Object> get props => [];
}
