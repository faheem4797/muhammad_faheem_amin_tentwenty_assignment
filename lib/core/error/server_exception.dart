import 'package:equatable/equatable.dart';

import 'package:dio/dio.dart';

class ServerException extends Equatable implements Exception {
  const ServerException([
    this.message = 'An unknown server exception occurred.',
  ]);
  factory ServerException.fromDioError(DioException dioError) {
    switch (dioError.response!.statusCode) {
      case 400:
        return ServerException('Bad request');
      case 404:
        return ServerException('Not found');
      case 500:
        return ServerException('Internal server error');
      default:
        return ServerException();
    }
  }

  final String message;

  @override
  List<Object?> get props => [message];
}
