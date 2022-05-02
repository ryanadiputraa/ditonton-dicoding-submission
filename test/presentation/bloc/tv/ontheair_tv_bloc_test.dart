import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_ontheair_tv.dart';
import 'package:ditonton/presentation/bloc/tv/ontheair/ontheair_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'ontheair_tv_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTv])
void main() {
  late MockGetOnTheAirTv mockGetOnTheAirTv;
  late OnTheAirTvBloc onTheAirTvBloc;

  setUp(() {
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    onTheAirTvBloc = OnTheAirTvBloc(mockGetOnTheAirTv);
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvList = <Tv>[tTv];

  test('initialState should be Empty', () {
    expect(onTheAirTvBloc.state, OnTheAirTvEmpty());
  });

  group("get on the air tv", () {
    blocTest<OnTheAirTvBloc, OnTheAirTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetOnTheAirTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return onTheAirTvBloc;
      },
      act: (bloc) => bloc.add(OnGetOnTheAirTv()),
      expect: () => [
        OnTheAirTvLoading(),
        HasOnTheAirTv(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
      },
    );

    blocTest<OnTheAirTvBloc, OnTheAirTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetOnTheAirTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return onTheAirTvBloc;
      },
      act: (bloc) => bloc.add(OnGetOnTheAirTv()),
      expect: () => [
        OnTheAirTvLoading(),
        OnTheAirTvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
      },
    );
  });
}
