import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_ontheair_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ontheair_tv_event.dart';
part 'ontheair_tv_state.dart';

class OnTheAirTvBloc extends Bloc<OnTheAirTvEvent, OnTheAirTvState> {
  final GetOnTheAirTv _getOnTheAirTv;

  OnTheAirTvBloc(this._getOnTheAirTv) : super(OnTheAirTvEmpty()) {
    on<OnGetOnTheAirTv>((event, emit) async {
      emit(OnTheAirTvLoading());
      final result = await _getOnTheAirTv.execute();

      result.fold(
        (failure) {
          emit(OnTheAirTvError(failure.message));
        },
        (data) {
          emit(HasOnTheAirTv(data));
        },
      );
    });
  }
}
