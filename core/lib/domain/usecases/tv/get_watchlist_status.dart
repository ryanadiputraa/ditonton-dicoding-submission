import 'package:core/domain/repositories/tv/tv_repository.dart';

class GetWatchlistStatus {
  final TvRepository repository;

  GetWatchlistStatus(this.repository);

  Future<bool> execute(int id) {
    return repository.isAddedToWatchlist(id);
  }
}
