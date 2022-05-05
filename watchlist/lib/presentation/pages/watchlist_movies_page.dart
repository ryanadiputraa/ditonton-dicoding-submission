import 'package:core/utils/utils.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_movies_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMoviesBloc>().add(const OnGetWatchlistMovies());
      context.read<WatchlistTvBloc>().add(const OnGetWatchlistTv());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(const OnGetWatchlistMovies());
    context.read<WatchlistTvBloc>().add(const OnGetWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
          builder: (context, state) {
            if (state is WatchlistMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HasWatchlistMovies) {
              final movies = state.result;
              return BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
                  builder: (context, state) {
                if (state is WatchlistTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HasWatchlistTv) {
                  final watchlistCount = movies.length + state.result.length;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      if (index < movies.length) {
                        final movie = movies[index];
                        return MovieCard(movie);
                      }
                      final tv = state.result[index - movies.length];
                      return TvCard(tv);
                    },
                    itemCount: watchlistCount,
                  );
                } else if (state is WatchlistTvError) {
                  return Center(
                    child: Text(state.message),
                    key: const Key("error_message"),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              });
            } else if (state is WatchlistMoviesError) {
              return Center(
                child: Text(state.message),
                key: const Key("error_message"),
              );
            } else {
              return Expanded(
                child: Container(),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
