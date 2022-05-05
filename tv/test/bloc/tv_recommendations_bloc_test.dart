import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecase/get_tv_recommendations.dart';
import 'package:tv/presentation/bloc/recommendations/tv_recommendations_bloc.dart';

import '../dummy_objects.dart';
import 'tv_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late MockGetTvRecommendations mockGetTvRecommendations;
  late TvRecommendationsBloc tvRecommendationsBloc;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvRecommendationsBloc = TvRecommendationsBloc(mockGetTvRecommendations);
  });

  const tId = 1;
  test('initialState should be Empty', () {
    expect(tvRecommendationsBloc.state, TvRecommendationsEmpty());
  });

  group("get recommendations movies", () {
    blocTest<TvRecommendationsBloc, TvRecommendationsState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTvlist));
        return tvRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const OnGetTvRecommendations(tId)),
      expect: () => [
        TvRecommendationsLoading(),
        HasTvRecommendations(testTvlist),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest<TvRecommendationsBloc, TvRecommendationsState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvRecommendations.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const OnGetTvRecommendations(tId)),
      expect: () => [
        TvRecommendationsLoading(),
        const TvRecommendationsError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
      },
    );
  });
}
