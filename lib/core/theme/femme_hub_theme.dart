import 'package:flutter/material.dart';

class FemmeHubTheme {
  static const Color rosaPrincipal = Color(0xFFE99CAE);
  static const Color verdeSuave = Color(0xFFC2DD80);
  static const Color rosaEscuro = Color(0xFFD56989);
  static const Color rosaClaro = Color(0xFFF3EEF2);

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: rosaClaro,
        colorScheme: const ColorScheme.light(
          primary: rosaEscuro,
          secondary: verdeSuave,
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.black87,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: rosaEscuro,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: rosaEscuro,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: rosaPrincipal),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: rosaPrincipal),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: rosaEscuro, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: rosaEscuro,
          foregroundColor: Colors.white,
        ),
      );
}
