import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_detail_tv.dart';
import 'package:ditonton/presentation/bloc/tv/tvdetail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetDetailTv])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetDetailTv mockGetDetailTv;

  const tId = 1;

  setUp(() {
    mockGetDetailTv = MockGetDetailTv();
    tvDetailBloc = TvDetailBloc(mockGetDetailTv);
  });

  test("Initial state should be empty", () {
    expect(tvDetailBloc.state, TvDetailEmpty());
  });

  blocTest<TvDetailBloc, TvDetailState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetDetailTv.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(OnGetTvDetail(tId)),
      expect: () => [
            TvDetailLoading(),
            HasTvDetail(testTvDetail),
          ],
      verify: (bloc) {
        verify(mockGetDetailTv.execute(tId));
        return OnGetTvDetail(tId).props;
      });

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetDetailTv.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetTvDetail(tId)),
    expect: () => [
      TvDetailLoading(),
      TvDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetDetailTv.execute(tId));
    },
  );
}
