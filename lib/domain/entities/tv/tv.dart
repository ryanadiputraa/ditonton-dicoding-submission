import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
    required this.backdropPath,
    required this.id,
    required this.genreIds,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        genreIds,
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
