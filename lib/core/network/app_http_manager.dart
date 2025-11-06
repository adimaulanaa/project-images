// file: core/network/app_http_manager.dart

// ignore_for_file: unnecessary_null_comparison, avoid_print, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:my_gallery/core/network/auth_interceptor.dart';
import 'package:my_gallery/core/network/error/exceptions.dart';
import 'package:my_gallery/core/storage/storage_provider.dart';
import 'package:my_gallery/env.dart';
import 'package:dio/io.dart';

abstract class HttpManager {
  // ... (Abstrak method Anda)
  Future<dynamic> download({
    required String url,
    String? path,
    Map<String, dynamic>? query,
    required Map<String, String> headers,
  });

  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, String> headers,
  });
  
  // ... (Method post, put, patch, delete lainnya)
  Future<Response> post({
    String? url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    FormData? formData,
    bool isUploadImage = false,
  });

  Future<Response> put({
    String? url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
  });

  Future<Response> patch({
    String? url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
  });

  Future<Response> delete({
    String? url,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    super.onError(err, handler);
  }
}

class AppHttpManager implements HttpManager {
  // 🟢 Anda harus memanggil AppHttpManager.instantiate(storage) di main.dart/DI
  // Saya membuat ini menjadi late field agar bisa diinisialisasi sekali.
  static late AppHttpManager instance;

  final String _baseUrl = Env().apiBaseUrl;
  final Dio _dio = Dio();
  // 🟢 Tambahkan field storage
  final StorageProvider storage; 

  final CacheOptions _cacheOptions = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.refreshForceCache,
    hitCacheOnNetworkFailure: true,
    hitCacheOnErrorCodes: [500, 502, 503],
    maxStale: const Duration(days: 7),
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
  );

  final Duration _httpTimeout = Duration(seconds: Env().configHttpTimeout);
  final Duration _httpUploadTimeout = Duration(
    seconds: Env().configHttpUploadTimeout,
  );

  // 🟢 Konstruktor baru menerima storage
  AppHttpManager._instantiate(this.storage) {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.sendTimeout = Duration(seconds: Env().configHttpTimeout);

    _dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));
    _dio.interceptors.add(CustomInterceptors());
    
    // 🟢 BARIS KRITIS: Tambahkan AuthInterceptor
    _dio.interceptors.add(AuthInterceptor(storage)); 

    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
  }
  
  // 🟢 Method pabrik statis (untuk menggantikan instance lama)
  static AppHttpManager instantiate(StorageProvider storage) {
     instance = AppHttpManager._instantiate(storage);
     return instance;
  }
  
  // Jika Anda tetap ingin menggunakan instance.instance, ganti ini:
  // static AppHttpManager get instance => _instance; // (Dengan asumsi _instance ada)


  @override
  Future<Response> delete({
    String? url,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      if (Env().isInDebugMode) {
        print('Api Delete request url $url');
      }

      final response = await _dio.delete(
        _queryBuilder(url, query),
        // AuthInterceptor akan menambahkan token
        options: Options(headers: _headerBuilder(headers)),
      );
      return _returnResponse(response) as Response;
    } catch (error) {
      await handleError(error);
      rethrow;
    }
  }

  @override
  Future get({
    String? url,
    Map<String, dynamic>? query,
    required Map<String, String> headers,
  }) async {
    try {
      if (Env().isInDebugMode) {
        print('Api Get request url $url, with $query');
      }
      
      // Token tidak perlu lagi di-handle di sini, Interceptor akan melakukannya.
      final standardOptions = Options(headers: _headerBuilder(headers)); 
      
      final requestCacheOptions = _cacheOptions.copyWith(
        maxStale: const Duration(days: 1),
        policy: CachePolicy.refresh,
      );
      final finalOptions = standardOptions.copyWith(
        extra: <String, dynamic>{
          ...standardOptions.extra ?? {},
          ...requestCacheOptions.toExtra(),
        },
      );

      final response = await _dio.get(
        _queryBuilder(url, query),
        options: finalOptions,
      );
      return _returnResponse(response);
    } catch (error) {
      await handleError(error);
      rethrow;
    }
  }

  // ... (Implementasi download, post, put, patch lainnya) ...
  
  @override
  Future download({
    String? url,
    String? path,
    Map<String, dynamic>? query,
    required Map<String, String> headers,
  }) async {
    try {
      final response = await _dio
          .download(
            _queryBuilder(url, query),
            path,
            options: Options(method: 'GET', headers: _headerBuilder(headers)),
          )
          .timeout(
            _httpUploadTimeout,
            onTimeout: () {
              throw NetworkException();
            },
          );

      return _returnResponse(response);
    } catch (error) {
      await handleError(error);
      rethrow;
    }
  }

  @override
  Future<Response> post({
    String? url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    FormData? formData,
    bool isUploadImage = false,
  }) async {
    try {
      if (Env().isInDebugMode) {
        print('Api Post request url $url, with $body');
      }

      final response = await _dio
          .post(
            _queryBuilder(url, query),
            data: formData ?? (body != null ? json.encode(body) : null),
            // AuthInterceptor akan menambahkan token
            options: Options(headers: _headerBuilder(headers)),
          )
          .timeout(
            (isUploadImage) ? _httpUploadTimeout : _httpTimeout,
            onTimeout: () {
              throw NetworkException();
            },
          );

      return _returnResponse(response) as Response;
    } catch (error) {
      await handleError(error);
      rethrow;
    }
  }

  @override
  Future<Response> put({
    String? url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
  }) async {
    try {
      if (Env().isInDebugMode) {
        print('Api Put request url $url, with $body');
      }

      final response = await _dio
          .put(
            _queryBuilder(url, query),
            data: formData ?? (body != null ? json.encode(body) : null),
            // AuthInterceptor akan menambahkan token
            options: Options(headers: _headerBuilder(headers)),
          )
          .timeout(
            _httpTimeout,
            onTimeout: () {
              throw NetworkException();
            },
          );
      return _returnResponse(response) as Response;
    } catch (error) {
      await handleError(error);
      rethrow;
    }
  }

  @override
  Future<Response> patch({
    String? url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
  }) async {
    try {
      if (Env().isInDebugMode) {
        print('Api Patch request url $url, with $body');
      }

      final response = await _dio
          .patch(
            _queryBuilder(url, query),
            data: formData ?? (body != null ? json.encode(body) : null),
            // AuthInterceptor akan menambahkan token
            options: Options(headers: _headerBuilder(headers)),
          )
          .timeout(
            _httpTimeout,
            onTimeout: () {
              throw NetworkException();
            },
          );
      return _returnResponse(response) as Response;
    } catch (error) {
      await handleError(error);
      rethrow;
    }
  }

  Map<String, dynamic> _headerBuilder(Map<String, dynamic>? headers) {
    final mutableHeaders = Map<String, dynamic>.from(headers ?? {});

    // Tambah default headers jika belum ada
    mutableHeaders.putIfAbsent(
      HttpHeaders.acceptHeader,
      () => 'application/json',
    );
    // Tambah default headers jika belum ada (hanya untuk POST/PUT/PATCH/DELETE)
    // Note: GET tidak selalu butuh Content-Type
    if (mutableHeaders[HttpHeaders.contentTypeHeader] == null) {
      mutableHeaders.putIfAbsent(
        HttpHeaders.contentTypeHeader,
        () => 'application/json',
      );
    }


    return mutableHeaders;
  }

  String _queryBuilder(String? path, Map<String, dynamic>? query) {
    final buffer = StringBuffer();
    buffer.write(Env().apiBaseUrl + path.toString());

    if (query != null) {
      if (query.isNotEmpty) {
        buffer.write('?');
      }
      query.forEach((key, value) {
        buffer.write('$key=$value&');
      });
    }
    if (Env().isInDebugMode) {
      print(buffer);
    }
    return buffer.toString();
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  dynamic _returnResponse(Response response) {
    if (Env().isInDebugMode) {
      print('Api response status: ${response.statusCode}');
      print('Api response uri: ${response.realUri}');
      print('Api response data: ${response.data}');
    }
    return response;
  }

  Future<void> handleError(dynamic error) async {
    if (error is DioException) {
      final response = error.response;

      String message = 'Terjadi kesalahan tidak diketahui';
      if (response != null) {
        try {
          if (response.data is Map<String, dynamic>) {
            final data = response.data as Map<String, dynamic>;
            if (data['message'] != null) {
              if (data['message'] is String) {
                message = data['message'];
              } else if (data['message'] is List) {
                message = (data['message'] as List).join(', ');
              }
            }
          } else if (response.data is String) {
            message = removeAllHtmlTags(response.data.toString());
          }
        } catch (_) {}
      }

      switch (response?.statusCode) {
        case 400:
          throw BadRequestException(message: message);
        case 401:
          throw InvalidCredentialException(message: message);
        case 403:
          throw UnauthorisedException(message: message);
        case 404:
          throw NotFoundException(message: message);
        case 422:
          throw InvalidCredentialException(message: message);
        default:
          throw ServerException(message: message);
      }
    } else if (error is TimeoutException || error is SocketException) {
      throw NetworkException();
    }

    throw FetchDataException(message: error.toString());
  }
}