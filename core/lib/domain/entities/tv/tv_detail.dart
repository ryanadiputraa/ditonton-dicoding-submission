import 'package:core/domain/entities/genre/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  const TvDetail({
    required this.backdropPath,
    required this.id,
    required this.genres,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        genres,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount
      ];
}
