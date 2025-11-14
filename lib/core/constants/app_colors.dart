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
}