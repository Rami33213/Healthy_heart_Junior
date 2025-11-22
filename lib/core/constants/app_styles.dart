// core/constants/app_styles.dart
import 'package:flutter/material.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';

class AppStyles {
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: Color(0xFF2D3748),
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
    color: Color(0xFF2D3748),
  );
  
  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: Color(0xFF2D3748),
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: Color(0xFF2D3748),
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: Color(0xFF2D3748),
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: Color(0xFF2D3748),
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: Color(0xFF2D3748),
  );
   static const TextStyle authAppName = TextStyle(
    color: Color(0xFF000000),
    fontWeight: FontWeight.w400,
    fontSize: 30,
  );

  static const TextStyle authTagline = TextStyle(
    fontSize: 18,
    color: Color(0xFF000000),
  );

  static const TextStyle authWelcomeTitle = TextStyle(
    color: AppColors.authTextPrimary,
    fontSize: 25,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle authFieldLabel = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.authTextPrimary,
  );

  static const TextStyle authButtonText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle authHelperText = TextStyle(
    fontSize: 10,
    color: AppColors.authTextSecondary,
  );

  static const TextStyle authLinkText = TextStyle(
    color: Colors.blue,
  );

  static const TextStyle authOrText = TextStyle(
    color: AppColors.authGreyText,
    fontSize: 18,
  );

  static const TextStyle authFooterText = TextStyle(
    color: Colors.black,
  );

  static const TextStyle authCheckboxText = TextStyle(
    color: AppColors.authCheckboxText,
  );
}