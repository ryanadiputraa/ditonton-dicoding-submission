import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:core/presentation/bloc/movie/watchlist/watchlist_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

const String watchlistAddMessage = 'Added to Watchlist';
const String watchlistRemoveMessage = 'Removed from Watchlist';
@GenerateMocks(
    [GetWatchlistMovies, GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late WatchlistMoviesBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMovieBloc = WatchlistMoviesBloc(mockGetWatchlistMovies,
        mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should change movies data when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(OnGetWatchlistMovies()),
    expect: () => [
      WatchlistMoviesLoading(),
      HasWatchlistMovies([testWatchlistMovie]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should return error when data is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(OnGetWatchlistMovies()),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesError("Can't get data"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should return watchlist status',
    build: () {
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(OnGetWatchlistStatus(testMovieDetail.id)),
    expect: () => [IsMovieAddedToWatchlist(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(testMovieDetail.id));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should show failure message when fail to save to watchlist',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure("Can't save to watchlist")));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(OnSaveWatchlistMovies(testMovieDetail)),
    expect: () => [
      WatchlistMoviesError("Can't save to watchlist"),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should show success message when successfully save to watchlist',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right(watchlistAddMessage));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(OnSaveWatchlistMovies(testMovieDetail)),
    expect: () => [WatchlistMovieMessage(watchlistAddMessage)],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should show failure message when fail to remove from watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure("Can't remove from watchlist")));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(OnRemoveWatchlistMovies(testMovieDetail)),
    expect: () => [
      WatchlistMoviesError("Can't remove from watchlist"),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should show success message when successfully remove from watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right(watchlistRemoveMessage));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(OnRemoveWatchlistMovies(testMovieDetail)),
    expect: () => [WatchlistMovieMessage(watchlistRemoveMessage)],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}
