import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:assignment_app/core/services/theme_service.dart';
import 'package:assignment_app/core/theme/app_theme.dart';
import 'package:assignment_app/core/constants/app_route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Assignment App',
          debugShowCheckedModeBanner: false,
          
          // Theme Configuration
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: themeService.theme,
          
          // Routing Configuration
          getPages: AppRoutes.page,
          initialRoute: AppRoutes.splashScreen,
          
          // Initial Screen
          home: child,
        );
      },
    );
  }
}