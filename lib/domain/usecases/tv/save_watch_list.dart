import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv/tv_repository.dart';

class SaveWatchList {
  final TvRepository repository;

  SaveWatchList(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchList(tv);
  }
}
