import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/nowplaying/nowplaying_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  test('initialState should be Empty', () {
    expect(nowPlayingMoviesBloc.state, NowPlayingEmpty());
  });

  group("get now playing movies", () {
    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(OnFetch()),
      expect: () => [
        NowPlayingLoading(),
        HasNowPlayingMovies(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(OnFetch()),
      expect: () => [
        NowPlayingLoading(),
        NowPlayingError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  // group("get popular movies", () {
  //   blocTest<NowPlayingMoviesBloc, MovieListState>(
  //     'Should emit [Loading, HasData] when data is gotten successfully',
  //     build: () {
  //       when(mockGetPopularMovies.execute())
  //           .thenAnswer((_) async => Right(tMovieList));
  //       return nowPlayingMoviesBloc;
  //     },
  //     act: (bloc) => bloc.add(OnGetPopularMovies()),
  //     expect: () => [
  //       PopularLoading(),
  //       MovieListHasPopular(tMovieList),
  //     ],
  //     verify: (bloc) {
  //       verify(mockGetPopularMovies.execute());
  //     },
  //   );

  //   blocTest<NowPlayingMoviesBloc, MovieListState>(
  //     'Should emit [Loading, Error] when get search is unsuccessful',
  //     build: () {
  //       when(mockGetPopularMovies.execute())
  //           .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
  //       return nowPlayingMoviesBloc;
  //     },
  //     act: (bloc) => bloc.add(OnGetPopularMovies()),
  //     expect: () => [
  //       PopularLoading(),
  //       PopularError('Server Failure'),
  //     ],
  //     verify: (bloc) {
  //       verify(mockGetPopularMovies.execute());
  //     },
  //   );
  // });

  // group("get top rated movies", () {
  //   blocTest<NowPlayingMoviesBloc, MovieListState>(
  //     'Should emit [Loading, HasData] when data is gotten successfully',
  //     build: () {
  //       when(mockGetTopRatedMovies.execute())
  //           .thenAnswer((_) async => Right(tMovieList));
  //       return nowPlayingMoviesBloc;
  //     },
  //     act: (bloc) => bloc.add(OnGetTopRatedMovies()),
  //     expect: () => [
  //       TopRatedLoading(),
  //       MovieListHasTopRated(tMovieList),
  //     ],
  //     verify: (bloc) {
  //       verify(mockGetTopRatedMovies.execute());
  //     },
  //   );

  //   blocTest<NowPlayingMoviesBloc, MovieListState>(
  //     'Should emit [Loading, Error] when get search is unsuccessful',
  //     build: () {
  //       when(mockGetTopRatedMovies.execute())
  //           .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
  //       return nowPlayingMoviesBloc;
  //     },
  //     act: (bloc) => bloc.add(OnGetTopRatedMovies()),
  //     expect: () => [
  //       TopRatedLoading(),
  //       TopRatedError('Server Failure'),
  //     ],
  //     verify: (bloc) {
  //       verify(mockGetTopRatedMovies.execute());
  //     },
  //   );
  // });
}
