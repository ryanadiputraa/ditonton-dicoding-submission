import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/repositories/tv/tv_repository.dart';
import 'package:core/utils/failure.dart';

class GetOnTheAirTv {
  final TvRepository repository;

  GetOnTheAirTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getOnTheAirTv();
  }
}
