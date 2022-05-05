import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecase/get_watchlist_tv.dart';
import 'package:watchlist/domain/usecase/get_watchlist_tv_status.dart';
import 'package:watchlist/domain/usecase/remove_watch_list.dart';
import 'package:watchlist/domain/usecase/save_watch_list.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_bloc.dart';

import '../dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

const String watchlistAddMessage = 'Added to Watchlist';
const String watchlistRemoveMessage = 'Removed from Watchlist';

@GenerateMocks(
    [GetWatchListTv, GetWatchlistStatus, SaveWatchList, RemoveWatchList])
void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchListTv mockGetWatchlistTv;
  late MockGetWatchlistStatus mockGetWatchListStatus;
  late MockSaveWatchList mockSaveWatchlist;
  late MockRemoveWatchList mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchListTv();
    mockGetWatchListStatus = MockGetWatchlistStatus();
    mockSaveWatchlist = MockSaveWatchList();
    mockRemoveWatchlist = MockRemoveWatchList();
    watchlistTvBloc = WatchlistTvBloc(mockGetWatchlistTv,
        mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should change tv data when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(const OnGetWatchlistTv()),
    expect: () => [
      WatchlistTvLoading(),
      HasWatchlistTv([testWatchlistTv]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should return error when data is unsuccessful',
    build: () {
      when(mockGetWatchlistTv.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure("Can't get data")));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(const OnGetWatchlistTv()),
    expect: () => [
      WatchlistTvLoading(),
      const WatchlistTvError("Can't get data"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should return watchlist status',
    build: () {
      when(mockGetWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(OnGetWatchlistTvStatus(testTvDetail.id)),
    expect: () => [const IsTvAddedToWatchlist(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(testTvDetail.id));
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should show failure message when fail to save to watchlist',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure("Can't save to watchlist")));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(const OnSaveWatchlistTv(testTvDetail)),
    expect: () => [
      const WatchlistTvError("Can't save to watchlist"),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should show success message when successfully save to watchlist',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right(watchlistAddMessage));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(const OnSaveWatchlistTv(testTvDetail)),
    expect: () => [const WatchlistTvMessage(watchlistAddMessage)],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should show failure message when fail to remove from watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail)).thenAnswer((_) async =>
          const Left(DatabaseFailure("Can't remove from watchlist")));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(const OnRemoveWatchlistTv(testTvDetail)),
    expect: () => [
      const WatchlistTvError("Can't remove from watchlist"),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should show success message when successfully remove from watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right(watchlistRemoveMessage));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(const OnRemoveWatchlistTv(testTvDetail)),
    expect: () => [const WatchlistTvMessage(watchlistRemoveMessage)],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail));
    },
  );
}
