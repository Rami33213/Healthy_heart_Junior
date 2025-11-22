// core/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2E5BFF);
  static const Color secondary = Color(0xFF00C6FF);
  static const Color accent = Color(0xFF00D4AA);
  static const Color danger = Color(0xFFFF4757);
  static const Color warning = Color(0xFFFFA726);
  static const Color success = Color(0xFF2ED573);
  
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF2D3748);
  static const Color textSecondary = Color(0xFF718096);
  
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2E5BFF), Color(0xFF00C6FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient successGradient = LinearGradient(
    colors: [Color(0xFF00D4AA), Color(0xFF2ED573)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
   static const Color authBackground = Color.fromARGB(251, 255, 255, 255);
  static const Color authCardBackground = Color(0xFFFFFFFF);
  static const Color authPrimary = Color(0xFF4169E1);
  static const Color authTextPrimary = Color(0xFF262626);
  static const Color authTextSecondary = Color(0xFF504F4F);
  static const Color authIconColor = Color(0xFF504F4F);
  static const Color authFieldBackground = Color(0xFFEDECEC);
  static const Color authBorderColor = Color(0xFFEDECEC);
  static const Color authShadowColor = Color(0xFFE0E0E0);
  static const Color authGreyText = Color(0xFF5B5B5B);
  static const Color authCheckboxText = Color(0xFF636566);
  
  static const Color authButtonBackground = Color(0xFF4169E1);
  static const Color authGoogleButtonBackground = Color(0xFF000000);
}