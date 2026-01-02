import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'storage_service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal() {
    _initializeDio();
  }

  late Dio _dio;
  final StorageService _storageService = StorageService();

  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token if required
          if (options.extra['requiresAuth'] == true) {
            final token = await _storageService.getAccessToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) async {
          // Handle 401 Unauthorized - token expired
          if (error.response?.statusCode == 401) {
            // Try to refresh token
            try {
              await _refreshToken();
              // Retry the original request
              final options = error.requestOptions;
              final token = await _storageService.getAccessToken();
              options.headers['Authorization'] = 'Bearer $token';
              final response = await _dio.fetch(options);
              return handler.resolve(response);
            } catch (e) {
              // Refresh failed, pass the error
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );

    // Add logging interceptor in debug mode
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
      ),
    );
  }

  Future<void> _refreshToken() async {
    try {
      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      final response = await _dio.post(
        ApiConfig.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      final newAccessToken = response.data['accessToken'];
      await _storageService.saveAccessToken(newAccessToken);
    } catch (e) {
      rethrow;
    }
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = false,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(
          extra: {'requiresAuth': requiresAuth},
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = false,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(
          extra: {'requiresAuth': requiresAuth},
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = false,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(
          extra: {'requiresAuth': requiresAuth},
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = false,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(
          extra: {'requiresAuth': requiresAuth},
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = false,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(
          extra: {'requiresAuth': requiresAuth},
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Upload file
  Future<Response> uploadFile(
    String path,
    String filePath, {
    String fieldName = 'file',
    Map<String, dynamic>? data,
    bool requiresAuth = true,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(filePath),
        if (data != null) ...data,
      });

      final response = await _dio.post(
        path,
        data: formData,
        options: Options(
          extra: {'requiresAuth': requiresAuth},
        ),
        onSendProgress: onSendProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Download file
  Future<Response> downloadFile(
    String url,
    String savePath, {
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Error handler
  Exception _handleError(DioException error) {
    String message = 'An error occurred';

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        
        // Try to extract error message from response
        if (data is Map) {
          if (data.containsKey('message')) {
            message = data['message'];
          } else if (data.containsKey('error')) {
            message = data['error'];
          } else if (data.containsKey('detail')) {
            // Handle FastAPI/Pydantic validation errors
            final detail = data['detail'];
            if (detail is List && detail.isNotEmpty) {
              final firstError = detail[0];
              if (firstError is Map && firstError.containsKey('msg')) {
                message = firstError['msg'];
              } else {
                message = detail.toString();
              }
            } else if (detail is String) {
              message = detail;
            } else {
              message = 'Validation error';
            }
          } else {
            switch (statusCode) {
              case 400:
                message = 'Bad request';
                break;
              case 401:
                message = 'Unauthorized. Please login again.';
                break;
              case 403:
                message = 'Access forbidden';
                break;
              case 404:
                message = 'Resource not found';
                break;
              case 422:
                message = 'Invalid input. Please check your data.';
                break;
              case 500:
                message = 'Server error. Please try again later.';
                break;
              default:
                message = 'An error occurred (${statusCode ?? 'unknown'})';
            }
          }
        } else {
          switch (statusCode) {
            case 400:
              message = 'Bad request';
              break;
            case 401:
              message = 'Unauthorized. Please login again.';
              break;
            case 403:
              message = 'Access forbidden';
              break;
            case 404:
              message = 'Resource not found';
              break;
            case 422:
              message = 'Invalid input. Please check your data.';
              break;
            case 500:
              message = 'Server error. Please try again later.';
              break;
            default:
              message = 'An error occurred (${statusCode ?? 'unknown'})';
          }
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        break;
      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') ?? false) {
          message = 'No internet connection. Please check your network.';
        } else if (error.message?.contains('HandshakeException') ?? false) {
          message = 'SSL/TLS connection error. Please check your internet connection.';
        } else if (error.message?.contains('Connection refused') ?? false) {
          message = 'Cannot connect to server. Please try again later.';
        } else {
          message = 'Network error: ${error.message ?? "Unknown error"}';
        }
        break;
      default:
        message = 'An unexpected error occurred';
    }

    return Exception(message);
  }

  // Get Dio instance for custom requests
  Dio get dio => _dio;
}
