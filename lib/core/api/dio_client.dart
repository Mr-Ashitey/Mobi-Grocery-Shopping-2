import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';

import 'dio_exception.dart';

class DioClient {
  late final Dio _dio;

  // DioClient constructor
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_URL']!,
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: "application/json",
          "apikey": dotenv.env['API_KEY']!
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
      response = await _dio.post(endpoint, data: body);

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw Failure(errorMessage);
    }
  }

  // patch endpoint
  Future<Response> patch(String endpoint, [Map<String, dynamic>? body]) async {
    Response response;

    try {
      response = await _dio.patch(endpoint, data: body);
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw Failure(errorMessage);
    }
  }

  // delete endpoint
  Future<void> delete(String endpoint) async {
    try {
      await _dio.delete(endpoint);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw Failure(errorMessage);
    }
  }
}
