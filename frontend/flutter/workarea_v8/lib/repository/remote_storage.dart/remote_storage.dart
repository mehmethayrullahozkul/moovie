import 'package:dio/dio.dart';

class API {
  static const String baseUrl = "http://10.0.2.2:3000";
  static const Duration receiveTimeout = Duration(seconds: 5);
  static const Duration connectTimeout = Duration(seconds: 3);
}

class RemoteStorage {
  static final Dio _dio = Dio();

  RemoteStorage._() {
    _dio.options.baseUrl = API.baseUrl;
    _dio.options.connectTimeout = API.connectTimeout;
    _dio.options.receiveTimeout = API.receiveTimeout;
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.headers["Accept"] = "application/json";
  }

  static final RemoteStorage _instance = RemoteStorage._();

  factory RemoteStorage() {
    return _instance;
  }

  /* Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  } */

  Future<Response> get(String path, {dynamic data}) {
    return _dio.get(path, data: data);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) {
    return _dio.delete(path, data: data);
  }

  Future<Response> patch(String path, {dynamic data}) {
    return _dio.patch(path, data: data);
  }
}
