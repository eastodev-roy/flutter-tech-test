import 'package:assignment_app/core/constants/app_route.dart';
import 'package:assignment_app/core/services/cache_service.dart';
import 'package:assignment_app/features/auth/data/models/user_model.dart';
import 'package:assignment_app/features/auth/data/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;
  final CacheService _cacheService;

  AuthController(this._authRepository, this._cacheService);

  final Rxn<User> user = Rxn<User>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  static const String _userKey = 'current_user_session';

  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
  }

  void _loadUserFromStorage() {
    try {
      final sessionUser = _cacheService.authBox.get(_userKey);
      if (sessionUser != null) {
        user.value = sessionUser;
      }
    } catch (e) {
      debugPrint('Error loading user session from Hive: $e');
    }
  }

  Future<void> _saveUserToStorage(User userData) async {
    await _cacheService.authBox.put(_userKey, userData);
  }

  Future<void> login(String usernameOrEmail, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final normalizedInput = usernameOrEmail.trim().toLowerCase();

      // Check local Hive users database first (for mock users from signup)
      final localUserMap = _cacheService.usersBox.get(normalizedInput);
      
      if (localUserMap != null) {
        if (localUserMap['password'] == password) {
          final loggedInUser = User.fromJson(Map<String, dynamic>.from(localUserMap));
          user.value = loggedInUser;
          await _saveUserToStorage(loggedInUser);
          Get.offAllNamed(AppRoutes.storefrontScreen);
          return;
        } else {
          errorMessage.value = 'Invalid password';
          Get.snackbar('Login Failed', 'The password you entered is incorrect.');
          return;
        }
      }

      // If not in local storage, try API
      final loggedInUser = await _authRepository.login(usernameOrEmail, password);
      user.value = loggedInUser;
      await _saveUserToStorage(loggedInUser);

      Get.offAllNamed(AppRoutes.storefrontScreen);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Invalid credentials or connection error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(Map<String, dynamic> userData) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final signedUpUser = await _authRepository.signup(userData);
      
      // Save user to local Hive users database so they can log in
      final localUserData = signedUpUser.toJson();
      localUserData['password'] = userData['password'];
      
      // Store by both username and email for easy lookup
      await _cacheService.usersBox.put(signedUpUser.username.toLowerCase(), localUserData);
      await _cacheService.usersBox.put(signedUpUser.email.toLowerCase(), localUserData);

      Get.snackbar('Success', 'Account created! You can now login.');
      Get.offAllNamed(AppRoutes.loginScreen);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Signup failed: ${e.toString()}');
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
    await _cacheService.authBox.delete(_userKey);
    user.value = null;
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  bool get isAuthenticated => user.value != null;
}
