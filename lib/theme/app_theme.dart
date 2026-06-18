// lib/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const Color primary    = Color(0xFFFF4D94);
  static const Color secondary  = Color(0xFF7B2FBE);
  static const Color accent     = Color(0xFFFFD60A);
  static const Color purple     = Color(0xFFBB44FF);
  static const Color pink       = Color(0xFFFF4D94);
  static const Color green      = Color(0xFF00E5A0);
  static const Color blue       = Color(0xFF64C8FF);
  static const Color red        = Color(0xFFFF4060);
  static const Color background = Color(0xFF1A0A2E);
  static const Color surface    = Color(0xFF2A1040);
  static const Color cardBg     = Color(0xFF350D50);
  static const Color textDark   = Color(0xFFFFFFFF);
  static const Color textMedium = Color(0xFFCCAAEE);
  static const Color textLight  = Color(0xFF886699);

  static const List<Color> tileColors = [
    Color(0xFFFF4D94), Color(0xFF7B2FBE), Color(0xFFFFD60A), Color(0xFF00E5A0),
    Color(0xFFFF8C00), Color(0xFF64C8FF), Color(0xFFDC50DC), Color(0xFF00D4C8),
  ];

  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [Color(0xFF1A0A2E), Color(0xFF2A1040)],
  );
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFF6BAA), Color(0xFFFF4D94)], begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
  static const LinearGradient classicGradient = LinearGradient(
    colors: [Color(0xFFFF4D94), Color(0xFFCC2070)], begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
  static const LinearGradient chainGradient = LinearGradient(
    colors: [Color(0xFF7B2FBE), Color(0xFF5A1A9A)], begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
  static const LinearGradient blitzGradient = LinearGradient(
    colors: [Color(0xFFFFD60A), Color(0xFFFF8C00)], begin: Alignment.topLeft, end: Alignment.bottomRight,
  );

  static List<BoxShadow> get cardShadow => [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 16, offset: const Offset(0,4))];
  static List<BoxShadow> tileShadow(Color c) => [BoxShadow(color: c.withOpacity(0.55), blurRadius: 10, offset: const Offset(0,4))];
  static List<BoxShadow> buttonShadow(Color c) => [BoxShadow(color: c.withOpacity(0.5), blurRadius: 14, offset: const Offset(0,6))];

  static TextStyle get displayLarge => const TextStyle(fontFamily:'Nunito',fontSize:48,fontWeight:FontWeight.w800,color:textDark);
  static TextStyle get displayMedium => const TextStyle(fontFamily:'Nunito',fontSize:36,fontWeight:FontWeight.w800,color:textDark);
  static TextStyle get titleLarge => const TextStyle(fontFamily:'Nunito',fontSize:28,fontWeight:FontWeight.w700,color:textDark);
  static TextStyle get titleMedium => const TextStyle(fontFamily:'Nunito',fontSize:22,fontWeight:FontWeight.w700,color:textDark);
  static TextStyle get bodyLarge => const TextStyle(fontFamily:'Nunito',fontSize:18,fontWeight:FontWeight.w600,color:textDark);
  static TextStyle get bodyMedium => const TextStyle(fontFamily:'Nunito',fontSize:16,color:textMedium);
  static TextStyle get labelLarge => const TextStyle(fontFamily:'Nunito',fontSize:14,fontWeight:FontWeight.w700,color:textDark);

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.dark),
    scaffoldBackgroundColor: background, fontFamily: 'Nunito',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent, elevation: 0, centerTitle: true,
      titleTextStyle: TextStyle(fontFamily:'Nunito',fontSize:24,fontWeight:FontWeight.w800,color:textDark),
    ),
  );
}
