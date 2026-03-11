import 'package:get/get.dart';
import 'package:assignment_app/core/services/theme_service.dart';

class LoginController extends GetxController {
  final ThemeService _themeService;

  LoginController(this._themeService);

  final RxBool isPasswordVisible = false.obs;
  final RxString username = ''.obs;
  final RxString password = ''.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleTheme() {
    _themeService.switchTheme();
  }

  void login() {
    // Implement login logic here
    print('Login with: ${username.value}, ${password.value}');
  }
}
