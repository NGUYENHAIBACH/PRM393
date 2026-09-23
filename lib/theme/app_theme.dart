import 'package:flutter/material.dart';

// Shared colors and ThemeData so every screen looks consistent
class AppTheme {
  static const Color seed = Color(0xFF5B4BDB);

  // Gradient used for headers, icon tiles and highlight cards
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6A5AE0), Color(0xFF9C6BF5)],
  );

  // Current theme mode of the whole app. MaterialApp listens to it,
  // so changing the value switches between light and dark instantly.
  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier(ThemeMode.light);

  static void toggleDarkMode(bool isDark) {
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  static ThemeData get light => _build(
        brightness: Brightness.light,
        background: const Color(0xFFF6F5FB),
        card: Colors.white,
        border: const Color(0xFFE9E7F3),
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        background: const Color(0xFF0F0E17),
        card: const Color(0xFF1A1928),
        border: const Color(0xFF2A2940),
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color card,
    required Color border,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      // Flat cards with a thin border and rounded corners
      cardTheme: CardThemeData(
        elevation: 0,
        color: card,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: border),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}
