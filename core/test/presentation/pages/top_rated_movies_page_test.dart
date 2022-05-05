import 'package:core/presentation/bloc/movie/toprated/toprated_movies_bloc.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/MockMovieBloc.dart';

void main() {
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;

  setUp(() {
    registerFallbackValue(MockTopRatedMoviesEvent());
    registerFallbackValue(MockTopRatedMoviesState());
    mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>(
      create: (context) => mockTopRatedMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state).thenReturn(TopRatedLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state)
        .thenReturn(HasTopRatedMovies(tMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state)
        .thenReturn(TopRatedError("message"));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
