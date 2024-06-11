
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkHandlerService {
  NetworkHandlerService._internal();

  static final NetworkHandlerService _instance = NetworkHandlerService._internal();

  factory NetworkHandlerService() => _instance;

  final Dio _dio = Dio();

  Dio get dio => _dio
    ..options = BaseOptions(
      baseUrl: 'https://api.example.com/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    )
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // options.contentType = 'application/json';
          // options.headers['Authorization'] = 'Bearer YOUR_ACCESS_TOKEN';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );

  Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get<T>(path, queryParameters: queryParameters);
      return response.data!;
    } on DioException catch (e) {
      // Handle specific Dio errors here (e.g., timeout, 404, etc.)
      if(kDebugMode){
      print('DioError: ${e.message}');
      }
      rethrow;
    }
  }

  Future<T> post<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.post<T>(path, data: data, queryParameters: queryParameters);
      return response.data!;
    } on DioException catch (e) {
      // Handle specific Dio errors here (e.g., timeout, 404, etc.)
      if(kDebugMode){
        print('DioError: ${e.message}');
      }
      rethrow;
    }
  }
}