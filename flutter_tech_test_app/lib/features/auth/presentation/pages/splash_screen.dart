import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignment_app/core/constants/app_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Using the same logo container style as LoginScreen
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.surface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Get.theme.colorScheme.primary.withOpacity(0.2),
                ),
              ),
              child: Icon(
                Icons.person_pin,
                size: 100,
                color: Get.theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Assignment App',
              style: Get.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
