import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:wiber_mobile/data/sharedpref/shared_preference_helper.dart';

import '../../data/network/constants/endpoints.dart';

@lazySingleton
class DioClient {
  // dio instance
  final Dio _dio;
  final SharedPreferenceHelper _sharedPreferenceHelper;

  // injecting dio instance
  DioClient(this._dio, this._sharedPreferenceHelper) {
    _dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout =
          Duration(milliseconds: Endpoints.connectionTimeout)
      ..options.receiveTimeout =
          Duration(milliseconds: Endpoints.receiveTimeout)
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.addAll([
        LogInterceptor(
          request: true,
          responseBody: true,
          requestBody: true,
          requestHeader: true,
        ),
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            if (!options.path.contains(Endpoints.baseUrl))
              return handler.next(options);

            // getting token
            var token = _sharedPreferenceHelper.authToken;
            if (token == null) return;

            options.headers
                .putIfAbsent('Authorization', () => 'Bearer ' + token);
            return handler.next(options);
          },
        ),
      ]);
  }

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
