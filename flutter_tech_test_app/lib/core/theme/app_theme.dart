import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:assignment_app/core/theme/app_colors.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightSecondary,
      surface: AppColors.lightCardBackground,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSurface: AppColors.lightTextPrimary,
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.lightTextPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 24.sp,
      ),
      bodyLarge: TextStyle(color: AppColors.lightTextPrimary, fontSize: 16.sp),
      bodyMedium: TextStyle(color: AppColors.lightTextSecondary, fontSize: 14.sp),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.lightBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.lightBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.lightPrimary, width: 2),
      ),
      hintStyle: TextStyle(color: AppColors.lightTextSecondary, fontSize: 14.sp),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary,
      surface: AppColors.darkCardBackground,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSurface: AppColors.darkTextPrimary,
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.darkTextPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 24.sp,
      ),
      bodyLarge: TextStyle(color: AppColors.darkTextPrimary, fontSize: 16.sp),
      bodyMedium: TextStyle(color: AppColors.darkTextSecondary, fontSize: 14.sp),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.darkPrimary, width: 2),
      ),
      hintStyle: TextStyle(color: AppColors.darkTextSecondary, fontSize: 14.sp),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );
}
