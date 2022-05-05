import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/repositories/tv/tv_repository.dart';
import 'package:core/utils/failure.dart';

class RemoveWatchList {
  final TvRepository repository;

  RemoveWatchList(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlist(tv);
  }
}
