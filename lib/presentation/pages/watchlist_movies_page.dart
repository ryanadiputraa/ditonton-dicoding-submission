import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMoviesBloc>().add(OnGetWatchlistMovies());
      Provider.of<WatchlistTvNotifier>(context, listen: false)
          .fetchWatchlistTv();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(OnGetWatchlistMovies());
    Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
          builder: (context, state) {
            if (state is WatchlistMoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HasWatchlistMovies) {
              final movies = state.result;
              return Consumer<WatchlistTvNotifier>(
                  builder: (context, data, child) {
                if (data.watchlistState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.watchlistState == RequestState.Loaded) {
                  final watchlistCount =
                      movies.length + data.watchlistTv.length;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      if (index < movies.length) {
                        final movie = movies[index];
                        return MovieCard(movie);
                      }
                      final tv = data.watchlistTv[index - movies.length];
                      return TvCard(tv);
                    },
                    itemCount: watchlistCount,
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(data.message),
                  );
                }
              });
            } else if (state is WatchlistMoviesError) {
              return Center(
                child: Text(state.message),
                key: Key("error_message"),
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
