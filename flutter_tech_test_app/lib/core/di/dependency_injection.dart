import 'package:assignment_app/core/services/api_services.dart';
import 'package:assignment_app/core/services/cache_service.dart';
import 'package:assignment_app/core/services/connectivity_service.dart';
import 'package:assignment_app/core/services/theme_service.dart';
import 'package:assignment_app/features/auth/login/presentation/controllers/login_controller.dart';
import 'package:assignment_app/features/auth/data/repository/auth_repository.dart';
import 'package:assignment_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:assignment_app/features/posts/data/repository/post_repository.dart';
import 'package:assignment_app/features/posts/presentation/controllers/post_controller.dart';
import 'package:assignment_app/features/home/presentation/controllers/home_screen_controller.dart';
import 'package:get/get.dart';
class DependencyInjection {
  DependencyInjection._();
  static Future<void> init() async {
    Get.lazyPut<CacheService>(() => CacheService(), fenix: true);
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<ConnectivityService>(() => ConnectivityService(), fenix: true);
    Get.lazyPut<ThemeService>(() => ThemeService(Get.find<CacheService>()), fenix: true);
    // Repositories
    Get.lazyPut<PostRepository>(() => PostRepository(Get.find<ApiService>()), fenix: true);
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find<ApiService>()), fenix: true);

    // Controllers
    Get.lazyPut<LoginController>(() => LoginController(Get.find<ThemeService>()), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut<PostController>(() => PostController(Get.find<PostRepository>()), fenix: true);
    Get.lazyPut<HomeScreenController>(() => HomeScreenController(), fenix: true); 
  }
  static void clear() {
    Get.deleteAll(force: true);
  }
}