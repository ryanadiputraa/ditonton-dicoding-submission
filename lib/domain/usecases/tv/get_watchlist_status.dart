import 'package:ditonton/domain/repositories/tv/tv_repository.dart';

class GetWatchListStatus {
  final TvRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id) {
    return repository.isAddedToWatchList(id);
  }
}
