import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/repositories/tv/tv_repository.dart';
import 'package:core/utils/failure.dart';

class SaveWatchList {
  final TvRepository repository;

  SaveWatchList(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlist(tv);
  }
}
