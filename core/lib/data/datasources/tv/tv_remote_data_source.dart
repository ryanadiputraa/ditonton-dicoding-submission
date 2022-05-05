// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:core/data/models/tv/tv_detail_model.dart';
import 'package:core/data/models/tv/tv_model.dart';
import 'package:core/data/models/tv/tv_response.dart';
import 'package:core/utils/exception.dart';
import 'package:http/io_client.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getOnTheAirTv();
  Future<List<TvModel>> getPopularTv();
  Future<List<TvModel>> getTopRatedTv();
  Future<TvDetailResponseModel> getDetailTv(int id);
  Future<List<TvModel>> getTvRecommendations(int id);
  Future<List<TvModel>> searchTv(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final IOClient client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getOnTheAirTv() async {
    final response =
        await client.get(Uri.parse("$BASE_URL/tv/on_the_air?$API_KEY"));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body)).tvList;
    }
    throw ServerException();
  }

  @override
  Future<List<TvModel>> getPopularTv() async {
    final response =
        await client.get(Uri.parse("$BASE_URL/tv/popular?$API_KEY"));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body)).tvList;
    }
    throw ServerException();
  }

  @override
  Future<List<TvModel>> getTopRatedTv() async {
    final response =
        await client.get(Uri.parse("$BASE_URL/tv/top_rated?$API_KEY"));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body)).tvList;
    }
    throw ServerException();
  }

  @override
  Future<TvDetailResponseModel> getDetailTv(int id) async {
    final response = await client.get(Uri.parse("$BASE_URL/tv/$id?$API_KEY"));
    if (response.statusCode == 200) {
      return TvDetailResponseModel.fromJson(jsonDecode(response.body));
    }
    throw ServerException();
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse("$BASE_URL/tv/$id/recommendations?$API_KEY"));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body)).tvList;
    }
    throw ServerException();
  }

  @override
  Future<List<TvModel>> searchTv(String query) async {
    final response = await client
        .get(Uri.parse("$BASE_URL/search/tv?$API_KEY&query=$query"));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body)).tvList;
    }
    throw ServerException();
  }
}
