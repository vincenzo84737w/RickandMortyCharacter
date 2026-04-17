import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  final Dio _dio;
  String? _authToken;
  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  ApiService._internal()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://rickandmortyapi.com/api',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
          },
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_authToken != null) {
            options.headers[HttpHeaders.authorizationHeader] =
                'Bearer $_authToken';
          }
          return handler.next(options);
        },
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }
  //metodi CRUD

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final resp = await _dio.get(path, queryParameters: queryParameters);
      return resp.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final resp = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return resp.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final resp = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return resp.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final resp = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return resp.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  dynamic _handleResponse(Response response) {
    final status = response.statusCode ?? 0;
    if (status >= 200 && status < 300) {
      return response.data;
    } else {
      throw ApiException(
        message: 'Errore API: ${response.statusMessage}',
        statusCode: status,
        data: response.data,
      );
    }
  }

  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  void updateHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;
  final dynamic data;
  final DioException? dioException;

  ApiException({
    required this.message,
    required this.statusCode,
    this.data,
    this.dioException,
  });

  factory ApiException.fromDioException(DioException error) {
    final response = error.response;
    final status = response?.statusCode ?? 0;
    String message = 'Errore imprevisto'; // Inizializzazione base

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        message = 'Connessione al server scaduta';
        break;
      case DioExceptionType.badResponse:
        // Qui usiamo il metodo per estrarre il messaggio se esiste nel JSON
        message = _staticExtractMessage(response); 
        break;
      case DioExceptionType.cancel:
        message = 'Richiesta annullata';
        break;
      case DioExceptionType.badCertificate:
        message = 'Certificato di sicurezza non valido';
        break;
      case DioExceptionType.connectionError:
        message = 'Nessuna connessione internet';
        break;
      case DioExceptionType.unknown:
      default:
        message = 'Errore di rete o del server';
        break;
    }

    return ApiException(
      message: message,
      statusCode: status,
      data: response?.data,
      dioException: error,
    );
  }

  static String _staticExtractMessage(Response? response) {
    if (response == null) return 'Errore del server';
    final data = response.data;
    if (data is Map<String, dynamic>) {
      if (data.containsKey('error')) return data['error'].toString();
      if (data.containsKey('message')) return data['message'].toString();
    }
    return response.statusMessage ?? 'Errore sconosciuto';
  }

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message)';
}
