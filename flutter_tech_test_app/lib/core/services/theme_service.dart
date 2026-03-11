import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignment_app/core/services/cache_service.dart';

class ThemeService extends GetxService {
  final CacheService _cacheService;
  static const String _themeKey = 'isDarkMode';

  ThemeService(this._cacheService);

  // Get current theme mode (from cache or system)
  ThemeMode get theme {
    final bool? isDarkMode = _cacheService.get<bool>(_themeKey);
    if (isDarkMode == null) {
      return ThemeMode.system;
    }
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  // Load theme mode for GetMaterialApp
  bool get isDark => theme == ThemeMode.dark;

  // Switch theme and save choice
  void switchTheme() {
    final bool currentlyDark = Get.isDarkMode;
    Get.changeThemeMode(currentlyDark ? ThemeMode.light : ThemeMode.dark);
    _cacheService.put(_themeKey, !currentlyDark);
  }

  // Set specific theme mode
  void setThemeMode(ThemeMode mode) {
    Get.changeThemeMode(mode);
    if (mode == ThemeMode.system) {
      _cacheService.delete(_themeKey);
    } else {
      _cacheService.put(_themeKey, mode == ThemeMode.dark);
    }
  }
}
