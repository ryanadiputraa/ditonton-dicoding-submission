part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetTvDetail extends TvDetailEvent {
  final int id;

  OnGetTvDetail(this.id);

  @override
  List<Object> get props => [];
}
