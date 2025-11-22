// core/theme/app_theme.dart
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Tajawal', // خط عربي - تأكد من إضافته في pubspec.yaml
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.authFieldBackground,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 0,
            color: AppColors.authFieldBackground,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.authPrimary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.danger,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.danger,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
//    static ThemeData get darkTheme {
//     return ThemeData(
//       primaryColor: AppColors.primary,
//       scaffoldBackgroundColor: Color(0xFF121212),
//       fontFamily: 'Tajawal',
//       appBarTheme: AppBarTheme(
//         backgroundColor: Color(0xFF1E1E1E),
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       textTheme: TextTheme(
//         displayLarge: TextStyle(
//           fontSize: 32, 
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//         displayMedium: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//         titleLarge: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.w600,
//           color: Colors.white,
//         ),
//         bodyLarge: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.normal,
//           color: Colors.white,
//         ),
//         bodyMedium: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.normal,
//           color: Colors.white70,
//         ),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: Color(0xFF2D2D2D),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(width: 0, color: Color(0xFF2D2D2D)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(width: 2, color: AppColors.primary),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(width: 2, color: AppColors.danger),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(width: 2, color: AppColors.danger),
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       ),
//       cardColor: Color(0xFF1E1E1E),
//       dialogBackgroundColor: Color(0xFF1E1E1E),
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         backgroundColor: Color(0xFF1E1E1E),
//       ),
//     );
//   }
// }
