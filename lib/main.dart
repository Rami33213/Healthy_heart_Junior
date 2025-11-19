// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_heart_junior/core/theme/app_theme.dart';
import 'package:healthy_heart_junior/presentation/views/main_app/main_app_view.dart';
import 'package:healthy_heart_junior/presentation/views/main_app/main_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'رعاية القلب الذكية',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: MainBinding(),
      home: const MainAppView(),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      defaultTransition: Transition.cupertino,
      themeMode: ThemeMode.light,
    );
  }
}
