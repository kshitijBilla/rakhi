import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // === PRIMARY COLOR PALETTE (from wireframe) ===
  static const Color primaryMaroon = Color(0xFF8B1A4A);
  static const Color primaryDark = Color(0xFF5C0E2E);
  static const Color primaryLight = Color(0xFFB84C7A);

  // === ACCENT COLORS ===
  static const Color goldAccent = Color(0xFFD4A853);
  static const Color goldLight = Color(0xFFE8C97A);
  static const Color goldDark = Color(0xFFA67C3D);

  // === SOS COLORS ===
  static const Color sosRed = Color(0xFFCC2936);
  static const Color sosRedDark = Color(0xFF991F28);
  static const Color sosRedLight = Color(0xFFE85D68);

  // === BACKGROUND & SURFACE ===
  static const Color backgroundPink = Color(0xFFFDF2F5);
  static const Color backgroundGradientStart = Color(0xFFFCE4EC);
  static const Color backgroundGradientEnd = Color(0xFFF8BBD0);
  static const Color surfaceWhite = Color(0xFFFFFBFE);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // === TEXT COLORS ===
  static const Color textPrimary = Color(0xFF2D1B30);
  static const Color textSecondary = Color(0xFF6B4C6E);
  static const Color textLight = Color(0xFF9B7A9E);
  static const Color textOnDark = Color(0xFFFFF0F5);

  // === STATUS COLORS ===
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);

  // === SAFE COLOR ===
  static const Color safeGreen = Color(0xFF27AE60);

  // === GRADIENTS ===
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryMaroon, primaryDark],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundGradientStart, backgroundGradientEnd, backgroundPink],
  );

  static const LinearGradient sosGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [sosRed, sosRedDark],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [goldLight, goldAccent, goldDark],
  );

  // === SHADOWS ===
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: primaryMaroon.withValues(alpha: 0.08),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get sosShadow => [
        BoxShadow(
          color: sosRed.withValues(alpha: 0.4),
          blurRadius: 30,
          spreadRadius: 5,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: sosRed.withValues(alpha: 0.2),
          blurRadius: 60,
          spreadRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];

  // === THEME DATA ===
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryMaroon,
        primary: primaryMaroon,
        secondary: goldAccent,
        surface: surfaceWhite,
        error: error,
      ),
      scaffoldBackgroundColor: backgroundPink,
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: primaryMaroon),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryMaroon,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryMaroon,
          side: const BorderSide(color: primaryMaroon, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryMaroon.withValues(alpha: 0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryMaroon.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryMaroon, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryMaroon,
        unselectedItemColor: textLight,
        type: BottomNavigationBarType.fixed,
        elevation: 20,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: sosRed,
        foregroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }
}
