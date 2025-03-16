import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ConnectionException extends Equatable implements Exception {
  const ConnectionException([
    this.message = 'An unknown connection exception occurred.',
  ]);
  factory ConnectionException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return ConnectionException("Request cancelled");

      case DioExceptionType.connectionTimeout:
        return ConnectionException("Connection timeout");

      case DioExceptionType.receiveTimeout:
        return ConnectionException("Receive timeout");

      case DioExceptionType.sendTimeout:
        return ConnectionException("Send timeout");
      default:
        return ConnectionException();
    }
  }

  final String message;

  @override
  List<Object?> get props => [message];
}
