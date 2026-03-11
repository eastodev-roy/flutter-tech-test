import 'package:assignment_app/core/services/api_services.dart';
import 'package:assignment_app/core/services/cache_service.dart';
import 'package:assignment_app/core/services/connectivity_service.dart';
import 'package:assignment_app/core/services/theme_service.dart';
import 'package:assignment_app/features/auth/presentation/controllers/login_controller.dart';
import 'package:get/get.dart';
class DependencyInjection {
  DependencyInjection._();
  static Future<void> init() async {
    Get.lazyPut<CacheService>(() => CacheService(), fenix: true);
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<ConnectivityService>(() => ConnectivityService(), fenix: true);
    Get.lazyPut<ThemeService>(() => ThemeService(Get.find<CacheService>()), fenix: true);

    // Get.lazyPut<HomeRepository>(
    //   () => HomeRepository(
    //     apiService: Get.find<ApiService>(),
    //     cacheService: Get.find<CacheService>(),
    //     connectivityService: Get.find<ConnectivityService>(),
    //   ),
    //   fenix: true,
    // );

    // Get.lazyPut<HomeService>(
    //   () => HomeService(
    //     repository: Get.find<HomeRepository>(),
    //     connectivityService: Get.find<ConnectivityService>(),
    //   ),
    //   fenix: true,
    // );

    // Controllers
    Get.lazyPut<LoginController>(() => LoginController(Get.find<ThemeService>()), fenix: true);
    // Get.lazyPut<HomeController>(
    //   () => HomeController(
    //     homeService: Get.find<HomeService>(),
    //     repository: Get.find<HomeRepository>(),
    //     connectivityService: Get.find<ConnectivityService>(),
    //   ),
    // );
  }
  static void clear() {
    Get.deleteAll(force: true);
  }
}