import 'package:flutter/material.dart';

class AppColors {
  // ======= BRAND COLORS =======
  static const MaterialColor primary = MaterialColor(0xFFE76F51, <int, Color>{
    50: Color(0xFFFFF0EB),
    100: Color(0xFFFFD9CC),
    200: Color(0xFFFFBFA6),
    300: Color(0xFFFFA380),
    400: Color(0xFFFF8860),
    500: Color(0xFFE76F51), // default
    600: Color(0xFFD96649),
    700: Color(0xFFBF553E),
    800: Color(0xFFA84433),
    900: Color(0xFF8C3228),
  });

  static const MaterialColor secondary = MaterialColor(0xFF3B4D61, <int, Color>{
    50: Color(0xFFE8EDF2),
    100: Color(0xFFC6D0DE),
    200: Color(0xFFA2B3CA),
    300: Color(0xFF7F96B6),
    400: Color(0xFF637BA4),
    500: Color(0xFF3B4D61), // default
    600: Color(0xFF324356),
    700: Color(0xFF29384B),
    800: Color(0xFF1F2E41),
    900: Color(0xFF141B2C),
  });

  static const MaterialColor tertiary = MaterialColor(0xFFCC5A3E, <int, Color>{
    50: Color(0xFFFFECE8),
    100: Color(0xFFFFCFC5),
    200: Color(0xFFFFB1A1),
    300: Color(0xFFFF937D),
    400: Color(0xFFFF7A5F),
    500: Color(0xFFCC5A3E), // default
    600: Color(0xFFB74F37),
    700: Color(0xFFA24330),
    800: Color(0xFF8D3729),
    900: Color(0xFF752C21),
  });
  static const Color primaryForeground = Color(
    0xFFF8F9FA,
  ); // teks di tombol primary
  static const Color secondaryForeground = Color(
    0xFFF8F9FA,
  ); // teks di tombol secondary

  // ======= TEXT COLORS =======
  static const Color textTitle = Color(0xFF2C3E50); // teks utama / judul
  static const Color textBody = Color(0xFF495867); // teks body / subtitle
  static const Color muted = Color(0xFF6C757D); // teks hint / muted

  // ======= BACKGROUND COLORS =======
  static const Color background = Color(
    0xFFF8F9FA,
  ); // warna terang / background utama
  static const Color card = Color(0xFFEDEEEF); // card / container bg
  static const Color popover = Color(0xFFFFFFFF); // popover background

  // ======= BORDER & INPUT =======
  static const Color border = Color(0xFFD1D5DB); // border / divider
  static const Color input = Color(0xFFE9ECEF); // input field background
  static const Color ring = Color(
    0xFFE76F51,
  ); // fokus outline / ring dari primary

  // ======= ACCENT =======
  static const Color accent = Color(0xFF3B4D61); // highlight sekunder / tombol
  static const Color accentForeground = Color(
    0xFFF8F9FA,
  ); // teks di tombol accent

  // ======= STATUS COLORS =======
  static const Color success = Color(0xFF2ECC71); // hijau lembut
  static const Color warning = Color(0xFFF1C40F); // kuning terang
  static const Color error = Color(0xFFE74C3C); // merah error

  // ======= SEMI TRANSPARENT =======
  static Color get onPrimaryLight => primary.withValues(alpha: 0.1);
  static Color get onSecondaryLight => secondary.withValues(alpha: 0.1);
  static Color get onErrorLight => error.withValues(alpha: 0.1);
}
