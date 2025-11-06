// file: core/network/auth_interceptor.dart

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_gallery/core/storage/storage_provider.dart';

class AuthInterceptor extends Interceptor {
  final StorageProvider storage;

  AuthInterceptor(this.storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Ambil token secara asynchronous
      final token = storage.token;

      // Tambahkan header Authorization: Bearer <token> JIKA token ada
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching token for AuthInterceptor: $e');
      }
    }
    
    // Lanjutkan permintaan
    return handler.next(options);
  }
}