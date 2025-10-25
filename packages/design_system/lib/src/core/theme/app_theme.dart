import 'package:design_system/src/core/colors/app_colors.dart';
import 'package:design_system/src/core/texts/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData dark = ThemeData.dark(useMaterial3: false).copyWith(
    scaffoldBackgroundColor: Color(0xFF1E1E1E),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0XFF0C1117),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    cardColor: const Color(0xFF1E1E1E),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFD9A441),
      secondary: Color(0xFF795548),
      error: Color(0xFFFF6B6B),
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white70,
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 80,
      indicatorColor: Color(0xFFD9A441).withValues(alpha: .15),
      labelTextStyle: WidgetStateProperty.all(const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(size: selected ? 32 : 26, color: selected ? Color(0xFFD9A441) : Colors.white70);
      }),
    ),
    textTheme: GoogleFonts.ralewayTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: Colors.white, displayColor: Colors.white),
    extensions: [
      const AppColors(primary: Color(0xFFD9A441), background: Color(0xFF121212), secondary: Color(0xFF2C2C2C)),
      const AppTextStyles(
        titleExtra: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 16),
      ),
    ],
  );
}
