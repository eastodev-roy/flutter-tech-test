import 'package:assignment_app/core/services/api_services.dart';
import 'package:assignment_app/features/auth/data/models/user_model.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<User> login(String username, String password) async {
    try {
      final response = await _apiService.post(
        'https://dummyjson.com/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );
      return User.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<User> signup(Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.post(
        'https://dummyjson.com/users/add',
        data: userData,
      );
      return User.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forgotPassword(String email) async {
    // DummyJSON doesn't have a forgot password endpoint
    // We will simulate it with a delay
    await Future.delayed(const Duration(seconds: 1));
  }
}
