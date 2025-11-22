// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/core/theme/app_theme.dart';
import 'package:healthy_heart_junior/presentation/views/auth/signin_view.dart';
import 'package:healthy_heart_junior/presentation/views/auth/signup_view.dart';
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
      title: 'Healthy heart',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: MainBinding(),
      home: AnimatedSplashScreen(
        splash: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.authPrimary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.favorite_border,
            color: Colors.white,
            size: 80,
          ),
        ),
        duration: 3000,
        nextScreen: const SignInView(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: AppColors.authPrimary,
        centered: true,
        splashIconSize: 120,
      ),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      defaultTransition: Transition.cupertino,
      themeMode: ThemeMode.light,
      getPages: [
        GetPage(name: '/signin', page: () => const SignInView()),
        GetPage(name: '/signup', page: () => const SignUpView()),
        GetPage(name: '/main', page: () => const MainAppView()),
      ],
    );
  }
}
