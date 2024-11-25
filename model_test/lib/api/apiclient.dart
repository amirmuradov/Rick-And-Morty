// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../exception/exception.dart';

class ApiClient {
  Dio dio = Dio();

  String baseUrl = 'https://rickandmortyapi.com/api/';

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        followRedirects: false,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
      ),
    );

    {
      dio.options.headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
    }
    {
      dio.options.headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
    }

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          request: true,
        ),
      );
    }
  }

  Future<Either<ApiException, T>> _handleResponse<T>(
    Future<Response> request,
    T Function(dynamic json)? fromJson,
  ) async {
    try {
      final response = await request;

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = response.data;
        return right(fromJson == null ? data : fromJson(data));
      } else {
        Map data = {};
        print('-------------');
        if (response.data.runtimeType is String) {
          data = jsonDecode(response.data);
          print('------- $data ------');
        } else {
          print('====== ${response.data} ======');
          data = response.data;
        }
        data.addAll({'status_code': response.statusCode});
        print('------- $data ------!!!!!!');
        return left(
          ApiErrorHandler.handleError(
            data,
          ),
        );
      }
    } catch (e) {
      if ((e is DioException)) {
        Map<String, dynamic> data = {};
        if (e.response?.data is String) {
          data = {
            'message': e.message,
            'error': e.error,
          };
        } else {
          data = e.response?.data;
        }
        data.addAll({'status_code': e.response?.statusCode});
        return left(
          ApiErrorHandler.handleError(
            data,
          ),
        );
      }
      return left(ApiErrorHandler.handleError({
        'status_code': 500,
        'error': (e),
        'api-enoint': fromJson.toString()
      }));
    }
  }

  Future<Either<Exception, T>> get<T>(
    String url, {
    T Function(dynamic json)? fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    final request = dio.get(url,
        options: Options(
          headers: dio.options.headers,
        ),
        queryParameters: {
          if (queryParameters != null) ...queryParameters,
        });
    return _handleResponse<T>(request, fromJson);
  }

  Future<Either<Exception, T>> post<T>(
    String url, {
    dynamic data,
    T Function(dynamic json)? fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    final request = dio.post(
      url,
      options: Options(
          headers: dio.options.headers,
          validateStatus: (status) => true,
          contentType: Headers.jsonContentType),
      data: data,
      queryParameters: queryParameters,
    );
    return _handleResponse<T>(request, fromJson);
  }

  Future<Either<ApiException, T>> put<T>(
    String url, {
    required dynamic data,
    T Function(dynamic json)? fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    final request = dio.put(
      url,
      options: Options(
          headers: dio.options.headers, validateStatus: (status) => true),
      data: data,
      queryParameters: queryParameters,
    );
    return _handleResponse<T>(request, fromJson);
  }

  Future<Either<ApiException, T>> patch<T>(
    String url, {
    required dynamic data,
    T Function(dynamic json)? fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    final request = dio.patch(
      url,
      options: Options(
          headers: dio.options.headers, validateStatus: (status) => true),
      data: data,
      queryParameters: queryParameters,
    );
    return _handleResponse<T>(request, fromJson);
  }

  Future<Either<Exception, T>> delete<T>(
    String url, {
    T Function(dynamic json)? fromJson,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    final request = dio.delete(
      url,
      options: Options(
          headers: dio.options.headers, validateStatus: (status) => true),
      queryParameters: queryParameters,
      data: data,
    );
    return _handleResponse<T>(request, fromJson);
  }

  Future<Either<Exception, T>> request<T>(
    String url, {
    String? method,
    dynamic data,
    T Function(dynamic json)? fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    final request = dio.request(
      url,
      options: Options(
        method: method,
        headers: dio.options.headers,
        validateStatus: (status) => true,
      ),
      data: data,
      queryParameters: queryParameters,
    );
    return _handleResponse<T>(request, fromJson);
  }
}
