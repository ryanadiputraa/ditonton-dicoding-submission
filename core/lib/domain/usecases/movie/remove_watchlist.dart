import 'package:core/domain/entities/movie/movie_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/repositories/movie/movie_repository.dart';
import 'package:core/utils/failure.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
