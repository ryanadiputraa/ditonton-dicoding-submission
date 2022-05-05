import 'package:core/data/datasources/tv/tv_local_data_source.dart';
import 'package:core/data/datasources/tv/tv_remote_data_source.dart';
import 'package:core/domain/repositories/tv/tv_repository.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([TvRepository, TvRemoteDataSource, TvLocalDataSource],
    customMocks: [MockSpec<IOClient>(as: #MockHttpClient)])
void main() {}
