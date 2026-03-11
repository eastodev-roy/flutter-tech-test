import 'package:assignment_app/app.dart';
import 'package:assignment_app/core/di/dependency_injection.dart';
import 'package:assignment_app/core/services/cache_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Cache Service (Hive)
  await CacheService().init();
  
  // Initialize Dependency Injection
  await DependencyInjection.init();
  
  runApp(const MyApp());
}
