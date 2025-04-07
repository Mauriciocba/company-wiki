import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Opción 1: Azul clásico
  static const bluePrimary = Color(0xFF1976D2);
  static const blueSecondary = Color(0xFF64B5F6);
  static const blueBackground = Color(0xFFF5F5F5);
  static const blueText = Color(0xFF212121);

  // Opción 2: Verde suave
  static const greenPrimary = Color(0xFF4CAF50);
  static const greenSecondary = Color(0xFF81C784);
  static const greenBackground = Color(0xFFF1F8E9);
  static const greenText = Color(0xFF263238);

  // Opción 3: Púrpura vibrante
  static const purplePrimary = Color(0xFF9C27B0);
  static const purpleSecondary = Color(0xFFE1BEE7);
  static const purpleBackground = Color(0xFFF3E5F5);
  static const purpleText = Color(0xFF1A1A1A);

  // Opción 4: Celeste minimalista
  static const skyPrimary = Color(0xFF071E29);
  static const skySecondary = Color(0xFF003953);
  static const skyBackground = Color(0xFFF9FAFB);
  static const skyText = Color(0xFF374151);
}


class AppTheme {
  // Opción 1: Azul clásico
  static ThemeData get blueTheme {
    return ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.poppinsTextTheme(),
      colorScheme: ColorScheme.light(
        primary: AppColors.bluePrimary,
        secondary: AppColors.blueSecondary,
        surface: AppColors.blueBackground,
        onPrimary: Colors.white,
        onSurface: AppColors.blueText,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bluePrimary,
        foregroundColor: Colors.white,
      ),
    );
  }

  // Opción 2: Verde suave
  static ThemeData get greenTheme {
    return ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.poppinsTextTheme(),
      colorScheme: ColorScheme.light(
        primary: AppColors.greenPrimary,
        secondary: AppColors.greenSecondary,
        surface: AppColors.greenBackground,
        onPrimary: Colors.white,
        onSurface: AppColors.greenText,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.greenPrimary,
        foregroundColor: Colors.white,
      ),
    );
  }

  // Opción 3: Púrpura vibrante
  static ThemeData get purpleTheme {
    return ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.poppinsTextTheme(),
      colorScheme: ColorScheme.light(
        primary: AppColors.purplePrimary,
        secondary: AppColors.purpleSecondary,
        surface: AppColors.purpleBackground,
        onPrimary: Colors.white,
        onSurface: AppColors.purpleText,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.purplePrimary,
        foregroundColor: Colors.white,
      ),
    );
  }

  // Opción 4: Celeste minimalista
  static ThemeData get bluedark {
    return ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.poppinsTextTheme(),
      colorScheme: ColorScheme.light(
        primary: AppColors.skyPrimary,
        secondary: AppColors.skySecondary,
        surface: AppColors.skyBackground,
        onPrimary: Colors.white,
        onSurface: AppColors.skyText,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.skyPrimary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
