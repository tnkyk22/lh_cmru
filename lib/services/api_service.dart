import 'package:dio/dio.dart';
import 'package:lh_cmru/services/share_pref_service.dart';
import 'package:lh_cmru/services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio;

  ApiService({String baseUrl = '$apiURL/api', int timeout = 5000})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: Duration(milliseconds: timeout),
          receiveTimeout: Duration(milliseconds: timeout),
          sendTimeout: Duration(milliseconds: timeout),
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(String url) async {
    return await _dio.get(url);
  }

  Future<Response> post(String url, dynamic data) async {
    return await _dio.post(url, data: data);
  }

  Future<Response> put(String url, dynamic data) async {
    return await _dio.put(url, data: data);
  }

  Future<void> changePassword(String newPassword) async {
    try {
      final userId = await SharePrefService()
          .getUserSession()
          .then((value) => value['userId']);
      final response = await put(
        '/users/$userId',
        {
          'password': newPassword,
        },
      );
      return response.data;
    } catch (e) {
      print('Error changing password: $e');
      throw e;
    }
  }

  // Add other HTTP methods as needed (put, delete, etc.)
}
