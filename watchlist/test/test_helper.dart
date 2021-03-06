import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/domain/repositories/movie/movie_repository.dart';
import 'package:core/domain/repositories/tv/tv_repository.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  TvRepository,
  DatabaseHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
