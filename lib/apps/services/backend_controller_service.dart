import 'package:dio/dio.dart';
import 'package:healing_apps/apps/services/api_token_service.dart';
import 'package:logger/logger.dart';
class BackendControllerService {
  
  
  String get baseUrl => 'http://10.0.2.2:8000/api/v1'; // IP emulator Android/ to access laravel backend on localhost
  // String get baseUrl => 'http://192.168.0.179:8000/api/v1'; // Ganti dengan URL backend Anda
  
  final Dio _dio = Dio();
  final ApiTokenService apiTokenService = ApiTokenService();
  final Options _options = Options(
    sendTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  
  final Logger _logger = Logger();
  
  Future<Response?> fetchData(String url) async {
    try {
      final response = await _dio.get(url);
      return response;
    } on DioException catch (e) {
      print('Dio error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }
  
  // Tambahkan metode lain sesuai kebutuhan
  //login dan register
  Future<Response?> postData(String url, Map<String, dynamic> data) async {
    _logger.i('Posting data to $url with payload: $data');
    final response = await _dio.post(url, data: data,options: _options);
    return response;
  }
  
  Future<Response?> getData(String url) async {
    try {
      final response = await _dio.get(url);
      return response;
    } on DioException catch (e) {
      print('Dio error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }
  
  //login
  Future<Response?> login(String email, String password) async {
    try {
      final response = await postData('$baseUrl/login', {
        'email': email,
        'password': password,
      });
      //save token if login success
      if(response != null && response.statusCode == 200){
        LoginModel loginModel = LoginModel.fromJson(response.data);
        
        if(loginModel.isValid){
          await apiTokenService.saveToken(loginModel);
        }else {
          throw Exception('Invalid login response: Token is empty');
        }
      }
      return response;
    } on DioException catch (e) {
      return e.response;
    } catch (e) {
      return null;
    }
  }
}