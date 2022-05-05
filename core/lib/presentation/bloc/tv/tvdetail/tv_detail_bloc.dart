import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/usecases/tv/get_detail_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetDetailTv _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(TvDetailEmpty()) {
    on<OnGetTvDetail>((event, emit) async {
      final int id = event.id;
      emit(TvDetailLoading());

      final result = await _getTvDetail.execute(id);

      result.fold(
        (failure) {
          emit(TvDetailError(failure.message));
        },
        (data) {
          emit(HasTvDetail(data));
        },
      );
    });
  }
}
