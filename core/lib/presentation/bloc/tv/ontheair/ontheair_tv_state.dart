part of 'ontheair_tv_bloc.dart';

abstract class OnTheAirTvState extends Equatable {
  const OnTheAirTvState();

  @override
  List<Object> get props => [];
}

class OnTheAirTvEmpty extends OnTheAirTvState {}

class OnTheAirTvLoading extends OnTheAirTvState {}

class OnTheAirTvError extends OnTheAirTvState {
  final String message;

  const OnTheAirTvError(this.message);

  @override
  List<Object> get props => [message];
}

class HasOnTheAirTv extends OnTheAirTvState {
  final List<Tv> result;

  const HasOnTheAirTv(this.result);

  @override
  List<Object> get props => [result];
}
