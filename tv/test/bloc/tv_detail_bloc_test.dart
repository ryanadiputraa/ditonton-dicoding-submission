import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecase/get_detail_tv.dart';
import 'package:tv/presentation/bloc/tvdetail/tv_detail_bloc.dart';

import '../dummy_objects.dart';
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
            .thenAnswer((_) async => const Right(testTvDetail));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetTvDetail(tId)),
      expect: () => [
            TvDetailLoading(),
            const HasTvDetail(testTvDetail),
          ],
      verify: (bloc) {
        verify(mockGetDetailTv.execute(tId));
        return const OnGetTvDetail(tId).props;
      });

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetDetailTv.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const OnGetTvDetail(tId)),
    expect: () => [
      TvDetailLoading(),
      const TvDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetDetailTv.execute(tId));
    },
  );
}
