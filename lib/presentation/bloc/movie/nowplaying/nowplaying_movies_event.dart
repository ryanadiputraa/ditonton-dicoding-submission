part of 'nowplaying_movies_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnFetch extends NowPlayingMoviesEvent {
  OnFetch();

  @override
  List<Object> get props => [];
}
