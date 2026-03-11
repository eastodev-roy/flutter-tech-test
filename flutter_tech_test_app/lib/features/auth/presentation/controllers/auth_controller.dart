import 'dart:convert';
import 'package:assignment_app/core/constants/app_route.dart';
import 'package:assignment_app/features/auth/data/models/user_model.dart';
import 'package:assignment_app/features/auth/data/repository/auth_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  final Rxn<User> user = Rxn<User>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  static const String _userKey = 'auth_user';
  static const String _localUsersKey = 'local_users'; // Stores Map<username, userDataWithPassword>

  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      user.value = User.fromJson(jsonDecode(userJson));
    }
  }

  Future<void> _saveUserToStorage(User userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(userData.toJson()));
  }

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Check local storage first (for mock users from signup)
      final prefs = await SharedPreferences.getInstance();
      final localUsersJson = prefs.getString(_localUsersKey);
      if (localUsersJson != null) {
        final Map<String, dynamic> localUsers = jsonDecode(localUsersJson);
        if (localUsers.containsKey(username)) {
          final userData = localUsers[username];
          if (userData['password'] == password) {
            final loggedInUser = User.fromJson(userData);
            user.value = loggedInUser;
            await _saveUserToStorage(loggedInUser);
            Get.offAllNamed(AppRoutes.storefrontScreen);
            return;
          }
        }
      }

      // If not in local storage, try API
      final loggedInUser = await _authRepository.login(username, password);
      user.value = loggedInUser;
      await _saveUserToStorage(loggedInUser);

      Get.offAllNamed(AppRoutes.storefrontScreen);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(Map<String, dynamic> userData) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final signedUpUser = await _authRepository.signup(userData);
      
      // Save user locally so they can log in (since API is mock)
      final prefs = await SharedPreferences.getInstance();
      final localUsersJson = prefs.getString(_localUsersKey) ?? '{}';
      final Map<String, dynamic> localUsers = jsonDecode(localUsersJson);
      
      // Store user data + password for local login simulation
      final localUserData = signedUpUser.toJson();
      localUserData['password'] = userData['password'];
      localUsers[signedUpUser.username] = localUserData;
      
      await prefs.setString(_localUsersKey, jsonEncode(localUsers));

      Get.snackbar('Success', 'Account created! You can now login.');
      Get.offAllNamed(AppRoutes.loginScreen);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      isLoading.value = true;
      await _authRepository.forgotPassword(email);
      Get.snackbar('Success', 'Instructions sent to $email');
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    user.value = null;
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  bool get isAuthenticated => user.value != null;
}
