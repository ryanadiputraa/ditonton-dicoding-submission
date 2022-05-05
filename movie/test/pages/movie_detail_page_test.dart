import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/moviedetail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/recommendations/recommendations_movies_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:watchlist/watchlist.dart';

import '../MockMovieBloc.dart';
import '../dummy_objects.dart';

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationsBloc mockMovieRecommendationsBloc;
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;

  setUp(() {
    registerFallbackValue(MockMovieDetailEvent());
    registerFallbackValue(MockMovieDetailState());
    mockMovieDetailBloc = MockMovieDetailBloc();

    registerFallbackValue(MockMovieRecommendationsEvent());
    registerFallbackValue(MockMovieRecommendationsState());
    mockMovieRecommendationsBloc = MockMovieRecommendationsBloc();

    registerFallbackValue(MockWatchlistMoviesEvent());
    registerFallbackValue(MockMovieRecommendationsState());
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<RecommendationsMoviesBloc>(
          create: (context) => mockMovieRecommendationsBloc,
        ),
        BlocProvider<WatchlistMoviesBloc>(
          create: (context) => mockWatchlistMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group("Movie detail page - watchlist ", () {
    testWidgets(
        'Watchlist button should display add icon when movie not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(const HasMovieDetail(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(HasRecommendationsMovies(testMovieList));
      when(() => mockWatchlistMoviesBloc.state)
          .thenReturn(const IsMovieAddedToWatchlist(false));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(
          _makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when movie is added to wathclist',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(const HasMovieDetail(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(HasRecommendationsMovies(testMovieList));
      when(() => mockWatchlistMoviesBloc.state)
          .thenReturn(const IsMovieAddedToWatchlist(true));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(
          _makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(const HasMovieDetail(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(HasRecommendationsMovies(testMovieList));
      when(() => mockWatchlistMoviesBloc.state)
          .thenReturn(const IsMovieAddedToWatchlist(false));

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(
          _makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when remove from watchlist',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(const HasMovieDetail(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(HasRecommendationsMovies(testMovieList));
      when(() => mockWatchlistMoviesBloc.state)
          .thenReturn(const IsMovieAddedToWatchlist(true));

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(
          _makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Removed from Watchlist'), findsOneWidget);
    });
  });
}
