import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

const int connectionTimeout = 15000; // in milliseconds
const int receiveTimeout = 15000; // in milliseconds

@module
abstract class NetworkModule {
  @lazySingleton
  Dio provideDio() {
    final dio = Dio(BaseOptions(
      baseUrl: "https://api.example.com",
      connectTimeout: const Duration(milliseconds: connectionTimeout),
      receiveTimeout: const Duration(milliseconds: receiveTimeout),
    ));
    return dio;
  }
}
