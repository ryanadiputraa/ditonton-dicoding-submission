import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecase/get_popular_tv.dart';
import 'package:tv/presentation/bloc/popular/popular_tv_bloc.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc popularTvBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
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
    expect(popularTvBloc.state, PopularTvEmpty());
  });

  group("get popular tv", () {
    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(const OnGetPopularTv()),
      expect: () => [
        PopularTvLoading(),
        HasPopularTv(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(const OnGetPopularTv()),
      expect: () => [
        PopularTvLoading(),
        const PopularTvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );
  });
}
