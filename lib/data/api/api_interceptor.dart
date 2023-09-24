import 'package:dio/dio.dart';

class Dummy extends Interceptor {}

class ApiInterceptor extends Interceptor {
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.cancel ||
        err.type == DioExceptionType.connectionError) {
      handler.reject(err);
    } else if (err.response?.statusCode == 500 || (err.response?.statusCode ?? 501) > 500) {
      // Server error
      handler.resolve(
        Response<dynamic>(
          requestOptions: err.requestOptions,
          data: err.response?.data == null
              ? <String, dynamic>{}
              : (err.response?.data).runtimeType == String
                  ? <String, dynamic>{}
                  : err.response?.data,
          statusCode: err.response?.statusCode,
          statusMessage: err.response?.statusMessage,
        ),
      );
    } else if (err.response?.statusCode == 401) {
      // Expired Token
    } else if (err.response?.statusCode == 406) {
      // 406 error
      handler.resolve(
        Response<dynamic>(
          requestOptions: err.requestOptions,
          data: err.response?.data == null
              ? <String, dynamic>{}
              : (err.response?.data).runtimeType == String
                  ? <String, dynamic>{}
                  : err.response?.data,
        ),
      );
    } else if (err.response?.statusCode == 400 || (err.response?.statusCode ?? 400) > 399) {
      // Generic error code
      handler.resolve(
        Response<dynamic>(
          requestOptions: err.requestOptions,
          data: err.response?.data == null
              ? <String, dynamic>{}
              : (err.response?.data).runtimeType == String
                  ? <String, dynamic>{}
                  : err.response?.data,
          statusCode: err.response?.statusCode,
          statusMessage: err.response?.statusMessage,
        ),
      );
    }
  }
}
