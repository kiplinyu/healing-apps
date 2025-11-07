import 'package:shared_preferences/shared_preferences.dart';

class LoginEntity {
  final String token;
  // final UserEntity? user;

  const LoginEntity({
    required this.token,
  });

  bool get isValid => token.isNotEmpty;
}

class LoginModel extends LoginEntity {
  const LoginModel({
    required super.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> body) {
    final data = body['data'];
    
    return LoginModel(
      token: data?['token'] ?? '',
    );
  }
  
  factory LoginModel.fromToken(String token) {
    return LoginModel(token: token);
  }
}

class ApiTokenService {
  // Simpan token ke SharedPreferences
  Future<void> saveToken(LoginModel loginModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_token', loginModel.token);
  }
  
  // Ambil token dari SharedPreferences
  Future<LoginModel?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return LoginModel.fromToken(prefs.getString('api_token') ?? '');
  }
  
  // Hapus token dari SharedPreferences
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('api_token');
  }
}