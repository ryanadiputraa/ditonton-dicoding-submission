import 'package:core/data/models/tv/tv_table.dart';
import 'package:core/domain/entities/genre/genre.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';

final testTv = Tv(
    backdropPath: "/b0BckgEovxYLBbIk5xXyWYQpmlT.jpg",
    id: 67419,
    genreIds: const [18],
    originalName: "Victoria",
    overview:
        "The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.",
    popularity: 11.520271,
    posterPath: "/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg",
    firstAirDate: "2016-08-28",
    name: "Victoria",
    voteAverage: 1.39,
    voteCount: 9);

final testTvlist = [testTv];

const testTvDetail = TvDetail(
  backdropPath: "/b0BckgEovxYLBbIk5xXyWYQpmlT.jpg",
  id: 67419,
  genres: [Genre(id: 18, name: "Drama")],
  originalName: "Victoria",
  overview:
      "The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.",
  popularity: 11.520271,
  posterPath: "/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg",
  firstAirDate: "2016-08-28",
  name: "Victoria",
  voteAverage: 1.39,
  voteCount: 9,
);

final testWatchlistTv = Tv.watchlist(
    id: 67419,
    overview:
        "The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.",
    posterPath: "/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg",
    name: "Victoria");

const testTvTable = TvTable(
    id: 67419,
    overview:
        "The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.",
    posterPath: "/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg",
    name: "Victoria");

final testTvMap = {
  "id": 67419,
  "overview":
      "The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.",
  "posterPath": "/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg",
  "name": "Victoria"
};
