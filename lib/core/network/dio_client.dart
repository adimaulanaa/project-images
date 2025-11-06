import 'package:dio/dio.dart';

Dio createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://notula.ai/', // Ganti dengan URL yang sesuai
      connectTimeout: Duration(seconds: 180),
      receiveTimeout: Duration(seconds: 120),
      headers: {'Content-Type': 'application/json'},
    ),
  );
  return dio;
}
