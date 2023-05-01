import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';

import 'dio_exception.dart';

class DioClient {
  late final Dio _dio;

  // DioClient constructor
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "",
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: "application/json"
        },
      ),
    );
  }
  // get endpoint
  Future<Response> get(String endpoint,
      [Map<String, dynamic>? queryParameters]) async {
    Response response;

    try {
      response = await _dio.get(endpoint, queryParameters: queryParameters);

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw Failure(errorMessage);
    }
  }

  // post endpoint
  Future<Response> post(String endpoint, [Map<String, dynamic>? body]) async {
    Response response;

    try {
      response = await _dio.get(endpoint, data: body);

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw Failure(errorMessage);
    }
  }

  // put endpoint
  Future<Response> put(String endpoint, [Map<String, dynamic>? body]) async {
    Response response;

    try {
      response = await _dio.put(endpoint, data: body);

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw Failure(errorMessage);
    }
  }

  // delete endpoint
  Future<Response> delete(String endpoint) async {
    Response response;

    try {
      response = await _dio.delete(endpoint);

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw Failure(errorMessage);
    }
  }
}
