import 'package:assignment_app/core/constants/app_route.dart';
import 'package:assignment_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _isPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Icon(Icons.person_pin, size: 80, color: Get.theme.colorScheme.primary),
            const SizedBox(height: 40),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'e.g. kminchelle',
              ),
            ),
            const SizedBox(height: 24),
            Obx(() => TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'e.g. 0lel0ux',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => _isPasswordVisible.toggle(),
                    ),
                  ),
                )),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.toNamed(AppRoutes.forgotPasswordScreen),
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 32),
            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.login(
                        _usernameController.text,
                        _passwordController.text,
                      ),
                      child: const Text('Login'),
                    ),
                  )),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.signupScreen),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
