import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_gallery/core/network/error/hendler_failure.dart';

class ExceptionHelper {
  /// Untuk handle response dengan status code selain 200
  static void handleResponse(Response response) {
    final code = response.statusCode ?? 0;
    final message = ErrorHandler.getErrorMessage(code);
    throw ServerFailure(message : message);
  }

  /// Untuk mengembalikan pesan error dari DioException
  static String getDioErrorMessage(DioException e) {
    // 🔹 debug log agar developer bisa tahu detailnya
    _logDioException(e);

    final response = e.response;

    // Jika response ada → cek data errornya
    if (response != null) {
      return ErrorHandler.getErrorMessageFromResponse(response);
    }

    // Jika tidak ada response → cek type + error asli
    return ErrorHandler.getErrorMessageFromType(
      e.type,
      originalError: e.error,
    );
  }

  /// Log detail DioException (hanya jalan di debug mode)
  static void _logDioException(DioException e) {
    assert(() {
      debugPrint('=== DioException ===');
      debugPrint('Type       : ${e.type}');
      debugPrint('Message    : ${e.message}');
      debugPrint('Error      : ${e.error}');
      debugPrint('StackTrace : ${e.stackTrace}');
      debugPrint('Response   : ${e.response?.data}');
      debugPrint('StatusCode : ${e.response?.statusCode}');
      debugPrint('====================');
      return true;
    }());
  }
}

class ErrorHandler {
  /// Handle berdasarkan response
  static String getErrorMessageFromResponse(Response response) {
    final code = response.statusCode ?? 0;

    try {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        if (data.containsKey('message')) return data['message'];
        if (data.containsKey('Message')) return data['Message'];
        if (data.containsKey('error')) return data['error'];
        if (data.containsKey('error_description')) return data['error_description'];
      }
    } catch (_) {}

    return getErrorMessage(code);
  }

  /// Handle berdasarkan status code dari response (200, 400, 500, dst)
  static String getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Error 400: Permintaan tidak valid.';
      case 401:
        return 'Error 401: Tidak dapat mengakses. Harap login kembali.';
      case 403:
        return 'Error 403: Akses ditolak.';
      case 404:
        return 'Error 404: Data tidak ditemukan.';
      case 500:
        return 'Error 500: Sistem sedang sibuk, silahkan coba beberapa saat lagi.';
      default:
        return 'Error Terjadi kesalahan pada server.';
    }
  }

  /// Handle berdasarkan tipe DioException + originalError
  static String getErrorMessageFromType(
    DioExceptionType type, {
    dynamic originalError,
  }) {
    switch (type) {
      case DioExceptionType.cancel:
        return 'Permintaan dibatalkan.';
      case DioExceptionType.connectionError:
        return 'Terjadi kesalahan koneksi.';
      case DioExceptionType.connectionTimeout:
        return 'Waktu koneksi ke server habis.';
      case DioExceptionType.receiveTimeout:
        return 'Waktu menerima data dari server habis.';
      case DioExceptionType.sendTimeout:
        return 'Waktu mengirim data ke server habis.';
      case DioExceptionType.badCertificate:
        return 'Sertifikat server tidak valid.';
      case DioExceptionType.unknown:
      default:
        // 🔹 di sini kita bisa tampilkan sedikit pesan asli kalau ada
        if (originalError != null) {
          return 'Terjadi gangguan jaringan: ${originalError.toString()}';
        }
        return getUnknownErrorMessage();
    }
  }

  /// Backup fallback
  static String getConnectionErrorMessage() =>
      'Terjadi kesalahan koneksi.';

  static String getTimeoutErrorMessage() =>
      'Waktu koneksi ke server habis.';

  static String getUnknownErrorMessage() =>
      'Terdapat gangguan sementara, periksa jaringan internet anda atau tutup aplikasi lalu coba beberapa saat lagi.';
}
