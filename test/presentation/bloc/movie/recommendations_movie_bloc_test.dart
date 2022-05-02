import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/recommendations/recommendations_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'recommendations_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late RecommendationsMoviesBloc recommendationsMoviesBloc;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationsMoviesBloc =
        RecommendationsMoviesBloc(mockGetMovieRecommendations);
  });

  const tId = 1;

  test('initialState should be Empty', () {
    expect(recommendationsMoviesBloc.state, RecommendationsEmpty());
  });

  group("get recommendations movies", () {
    blocTest<RecommendationsMoviesBloc, RecommendationsMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return recommendationsMoviesBloc;
      },
      act: (bloc) => bloc.add(OnGetRecommendationsMovies(tId)),
      expect: () => [
        RecommendationsLoading(),
        HasRecommendationsMovies(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<RecommendationsMoviesBloc, RecommendationsMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return recommendationsMoviesBloc;
      },
      act: (bloc) => bloc.add(OnGetRecommendationsMovies(tId)),
      expect: () => [
        RecommendationsLoading(),
        RecommendationsError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });
}
