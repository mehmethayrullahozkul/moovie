import 'package:dio/dio.dart';

class API {
  static const String baseUrl = "https://ozkuls.com";
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

  Future<Response> get(String path, {dynamic body, dynamic headers}) {
    return _dio.get(path, data: body, options: Options(headers: headers));
  }

  Future<Response> post(String path, {dynamic body, dynamic headers}) {
    return _dio.post(path, data: body, options: Options(headers: headers));
  }

  Future<Response> put(String path, {dynamic body, dynamic headers}) {
    return _dio.put(path, data: body, options: Options(headers: headers));
  }

  Future<Response> delete(String path, {dynamic body, dynamic headers}) {
    return _dio.delete(path, data: body, options: Options(headers: headers));
  }

  Future<Response> patch(String path, {dynamic body, dynamic headers}) {
    return _dio.patch(path, data: body, options: Options(headers: headers));
  }
}
