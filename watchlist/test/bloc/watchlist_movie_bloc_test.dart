import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../dummy_objects.dart';
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
    act: (bloc) => bloc.add(const OnGetWatchlistMovies()),
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
      when(mockGetWatchlistMovies.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure("Can't get data")));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(const OnGetWatchlistMovies()),
    expect: () => [
      WatchlistMoviesLoading(),
      const WatchlistMoviesError("Can't get data"),
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
    expect: () => [const IsMovieAddedToWatchlist(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(testMovieDetail.id));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should show failure message when fail to save to watchlist',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure("Can't save to watchlist")));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(const OnSaveWatchlistMovies(testMovieDetail)),
    expect: () => [
      const WatchlistMoviesError("Can't save to watchlist"),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should show success message when successfully save to watchlist',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right(watchlistAddMessage));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(const OnSaveWatchlistMovies(testMovieDetail)),
    expect: () => [const WatchlistMovieMessage(watchlistAddMessage)],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should show failure message when fail to remove from watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
          const Left(DatabaseFailure("Can't remove from watchlist")));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(const OnRemoveWatchlistMovies(testMovieDetail)),
    expect: () => [
      const WatchlistMoviesError("Can't remove from watchlist"),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should show success message when successfully remove from watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right(watchlistRemoveMessage));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(const OnRemoveWatchlistMovies(testMovieDetail)),
    expect: () => [const WatchlistMovieMessage(watchlistRemoveMessage)],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}
