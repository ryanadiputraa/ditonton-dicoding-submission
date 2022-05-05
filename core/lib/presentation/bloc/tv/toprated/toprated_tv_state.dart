part of 'toprated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

class TopRatedTvEmpty extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvError extends TopRatedTvState {
  final String message;

  const TopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}

class HasTopRatedTv extends TopRatedTvState {
  final List<Tv> result;

  const HasTopRatedTv(this.result);

  @override
  List<Object> get props => [result];
}
