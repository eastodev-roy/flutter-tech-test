import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignment_app/features/auth/presentation/controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: controller.toggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Logo Container (Glassmorphism look from image)
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
                size: 80,
                color: Get.theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Welcome back',
              style: Get.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Please enter your details to sign in',
              style: Get.textTheme.bodyMedium,
            ),
            const SizedBox(height: 40),
            // Username Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Username or Email',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (v) => controller.username.value = v,
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Password Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Password',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Obx(() => TextField(
                      onChanged: (v) => controller.password.value = v,
                      obscureText: !controller.isPasswordVisible.value,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Get.theme.colorScheme.secondary,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: controller.login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: Get.theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
