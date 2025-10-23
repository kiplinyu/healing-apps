import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healing_apps/apps/models/destination_model.dart';
import 'package:healing_apps/apps/models/user_model.dart';
import 'package:healing_apps/apps/services/api_token_service.dart';
import 'package:logger/logger.dart';

class BackendControllerService
{
    static int GET = 0;
    static int POST = 1;
    static int PUT = 2;
    static int DELETE = 3;

    String get baseUrl => dotenv.get("BASE_URL"); // IP emulator Android/ to access laravel backend on localhost
    final Dio _dio = Dio();

    final ApiTokenService apiTokenService = ApiTokenService();

    Future<Response?> fetch(String url, int type, {Map<String, dynamic>? data}) async
    {
        try
        {
            final String? tokenString = (await apiTokenService.getToken())?.token;
            final Options options = Options(
                sendTimeout: Duration(seconds: 3),
                receiveTimeout: Duration(seconds: 3),
                headers:
                {
                    'Authorization': 'Bearer $tokenString',
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                },
                validateStatus: (status) => status != null && status >= 200 && status < 500,
            );
            switch (type)
            {
                case 0:
                    return await _dio.get(url, data: data, options: options);
                case 1:
                    return await _dio.post(url, data: data, options: options);
                case 2:
                    return await _dio.put(url, data: data, options: options);
                case 3:
                    return await _dio.delete(url, data: data, options: options);
                default:
                return null;
            }
        }
        on DioException catch (e)
        {
            return e.response;
        }
        catch (e)
        {
            return null;
        }
    }

    Future<UserModel?> getUser() async
    {
        final response = await fetch('$baseUrl/user', GET);
        if (response?.statusCode != 200)
        {
            return null;
        }
        //add token to response data
        final String? tokenString = (await apiTokenService.getToken())?.token;
        response?.data['data']['token'] = tokenString ?? '';
        final userModel = UserModel.fromJson(response?.data['data']);
        return userModel;
    }

    Future<Response?> getData(String url) async
    {
        try
        {
            final response = fetch(url, GET);
            return response;
        }
        on DioException catch (e)
        {
            print('Dio error: ${e.response?.data ?? e.message}');
            return null;
        }
        catch (e)
        {
            Logger().e('Unexpected error: $e');
            return null;
        }
    }

    //login
    Future<Response?> login(String email, String password) async
    {
        try
        {
            final response = await fetch('$baseUrl/login', POST, data:
                {
                    'email': email,
                    'password': password,
                }
            );
            //save token if login success
            if (response != null && response.statusCode == 200)
            {
                LoginModel loginModel = LoginModel.fromJson(response.data);

                if (loginModel.isValid)
                {
                    await apiTokenService.saveToken(loginModel);
                }
                else
                {
                    throw Exception('Invalid login response: Token is empty');
                }
            }

            //save user
            await getUser();
            return response;
        }
        on DioException catch (e)
        {
            return e.response;
        }
        catch (e)
        {
            return null;
        }
    }

    Future<Response?> logout() async
    {
        apiTokenService.clearToken();
        Response? response;
        try
        {
            response = await fetch("$baseUrl/logout", POST);
        }
        on DioException catch (e)
        {
            return e.response;
        }
        return response;
    }

    Future<Response?> resetPassword(String current, String password, String confirmPassword) async
    {
        try
        {
            final response = await fetch('$baseUrl/password', PUT, data:
                {
                    'current_password': current,
                    'password': password,
                    'password_confirmation': confirmPassword,
                }
            );
            return response;
        }
        on DioException catch (e)
        {
            return e.response;
        }
        catch (e)
        {
            return null;
        }
    }

    Future<Response?> updateUserProfile(UserModel updatedUser) async
    {
        try
        {
            final response = await fetch('$baseUrl/profile/edit', PUT, data: 
                {
                    'name': updatedUser.name,
                    'username': updatedUser.username,
                    'email': updatedUser.email,
                    'personal_data':
                    {
                        'phone_number': updatedUser.phone,
                    }
                }
            );
            return response;
        }
        on DioException catch (e)
        {
            return e.response;
        }
        catch (e)
        {
            return null;
        }
    }
    
    // Destination fetching
    Future<List<Destination>?> getDestinations() async
    {
        try{
            final response = await fetch('$baseUrl/destinations', GET);
            if (response?.statusCode != 200)
            {
                return null;
            }
            List<dynamic> data = response?.data['data'] ?? [];
            List<Destination> destinations = data.map(
                    (item) => Destination.fromJson(item)
            ).toList();
            return destinations;
        }
        on DioException catch (e) {
            Logger().e(
                'Dio error while fetching destinations: ${e.response?.data ??
                    e.message}');
            return null;
        }catch (e) {
            Logger().e('Unexpected error while fetching destinations: $e');
            return null;
        }
    }
}
