import './dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:invoder_app/utils/clean_map.dart';

enum HttpMethod { get, post, put, delete }

class ApiResult {
  final dynamic data;
  final bool error;
  final String? message;
  final int statusCode;

  ApiResult(
      {this.data, this.error = false, this.message, required this.statusCode});
}

class ApiService {
  final DioClient _dioClient;

  ApiService() : _dioClient = DioClient();

  dynamic data;

  Future<ApiResult> request(
    String uri, {
    HttpMethod method = HttpMethod.get,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      switch (method) {
        case HttpMethod.get:
          this.data = await _dioClient.get(
            uri,
            queryParameters:
                queryParameters != null ? cleanMap(queryParameters) : null,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case HttpMethod.post:
          this.data = await _dioClient.post(
            uri,
            data: data is Map || data == null
                ? data != null
                    ? cleanMap(data)
                    : null
                : data,
            queryParameters:
                queryParameters != null ? cleanMap(queryParameters) : null,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case HttpMethod.put:
          this.data = await _dioClient.put(
            uri,
            data: data != null ? cleanMap(data) : null,
            queryParameters:
                queryParameters != null ? cleanMap(queryParameters) : null,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case HttpMethod.delete:
          this.data = await _dioClient.delete(
            uri,
            data: data != null ? cleanMap(data) : null,
            queryParameters:
                queryParameters != null ? cleanMap(queryParameters) : null,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;
      }
      return ApiResult(data: this.data, error: false, statusCode: 200);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Api Error: $e');
      }
      if (e is DioException) {
        return ApiResult(
          data: e.response?.data,
          error: true,
          message: e.response?.data['message'] ?? 'Something went wrong',
          statusCode: e.response?.statusCode ?? 500,
        );
      }

      return ApiResult(
          data: e,
          error: true,
          message: 'Something went wrong',
          statusCode: 500);
    }
  }
}
