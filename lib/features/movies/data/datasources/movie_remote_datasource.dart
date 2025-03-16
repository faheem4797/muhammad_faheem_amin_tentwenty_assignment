import 'package:flutter/widgets.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/constants/constants.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/error/connection_exception.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/error/server_exception.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/data/models/upcoming_movie_model.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/data/models/video_model.dart';

import 'package:dio/dio.dart';

abstract interface class MovieRemoteDatasource {
  Future<List<UpcomingMovieModel>> getUpcomingMovies();
  Future<VideoModel> getTrailerPath({required String movieId});
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final Dio dio;
  MovieRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<UpcomingMovieModel>> getUpcomingMovies() async {
    try {
      final response = await dio.get(
        Constants.upcomingMoviesBaseUrl,
        queryParameters: {'api_key': Constants.apiKey},
      );

      if (response.statusCode == 200) {
        try {
          final results = response.data['results'] as List;
          return results
              .map((movie) => UpcomingMovieModel.fromMap(movie))
              .toList();
        } catch (e) {
          throw ServerException();
        }
      } else {
        debugPrint("error while json decoding");
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.cancel) {
        throw ConnectionException.fromDioError(e);
      } else if (e.type == DioExceptionType.badResponse) {
        throw ServerException.fromDioError(e);
      } else {
        throw ServerException(e.message ?? 'An error occurred');
      }
    } on ServerException {
      rethrow;
    } on ConnectionException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<VideoModel> getTrailerPath({required String movieId}) async {
    try {
      final response = await dio.get(
        '${Constants.movieVideoUrl}$movieId/videos',
        queryParameters: {'api_key': Constants.apiKey},
      );

      if (response.statusCode == 200) {
        try {
          final results = response.data['results'] as List;
          final listOfVideoModels =
              results.map((movie) => VideoModel.fromMap(movie)).toList();
          final videoModel = listOfVideoModels.firstWhere(
            (element) =>
                (element.site == 'YouTube' && element.type == "Trailer"),
            orElse: () => listOfVideoModels.first,
          );
          return videoModel;
        } catch (e) {
          throw ServerException();
        }
      } else {
        debugPrint("error while json decoding");
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.cancel) {
        throw ConnectionException.fromDioError(e);
      } else if (e.type == DioExceptionType.badResponse) {
        throw ServerException.fromDioError(e);
      } else {
        throw ServerException(e.message ?? 'An error occurred');
      }
    } on ServerException {
      rethrow;
    } on ConnectionException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
