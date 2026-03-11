import 'package:assignment_app/features/auth/login/presentation/pages/login_screen.dart';
import 'package:assignment_app/features/auth/login/presentation/pages/splash_screen.dart';
import 'package:assignment_app/features/home/presentation/pages/home_screen.dart';
import 'package:assignment_app/features/home/presentation/pages/product_detail_screen.dart';
import 'package:assignment_app/features/auth/presentation/pages/signup_screen.dart';
import 'package:assignment_app/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:assignment_app/features/posts/presentation/pages/posts_page.dart';
import 'package:assignment_app/features/posts/presentation/pages/post_detail_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static String loginScreen = "/login_screen";
  static String splashScreen = "/splash_screen";
  static const String storefrontScreen = '/storefront';
  static const String productDetailScreen = '/productDetailScreen';
  static const String signupScreen = '/signupScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String postScreen = '/posts';
  static String postDetail = "/post_detail";

  static List<GetPage> page = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: storefrontScreen, page: () => const HomeScreen()),
    GetPage(name: productDetailScreen, page: () => const ProductDetailScreen()),
    GetPage(name: signupScreen, page: () => const SignupScreen()),
    GetPage(name: forgotPasswordScreen, page: () => const ForgotPasswordScreen()),
    GetPage(name: postScreen, page: () => const PostsPage()),
    GetPage(name: postDetail, page: () => const PostDetailPage()),
  ];
}
