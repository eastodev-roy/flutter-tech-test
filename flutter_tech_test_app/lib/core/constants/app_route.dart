import 'package:assignment_app/features/auth/presentation/pages/login_screen.dart';
import 'package:assignment_app/features/auth/presentation/pages/splash_screen.dart';
import 'package:get/get.dart';


class AppRoutes {
  static String loginScreen = "/login_screen";
  static String splashScreen = "/splash_screen";


  static List<GetPage> page = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
  ];
}