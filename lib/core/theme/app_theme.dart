import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Centralized theme configuration for the app.
/// Use [AppTheme.light] and [AppTheme.dark] in [MaterialApp.theme] and
/// [MaterialApp.darkTheme]. Extend by adding more [ThemeData] customizations
/// (e.g. [TextTheme], [AppBarTheme], [InputDecorationTheme]) as needed.
abstract final class AppTheme {
  AppTheme._();

  /// Light theme based on [ThemeData.light] with Material 3 and app [ColorScheme].
  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: AppColors.light,
      scaffoldBackgroundColor: AppColors.light.surface,
      useMaterial3: true,
      // Add more overrides here (e.g. appBarTheme, cardTheme, inputDecorationTheme).
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.light.surface,
        foregroundColor: AppColors.light.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.light.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.light.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: CardThemeData(
        color: AppColors.light.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.tertiary,
          foregroundColor: AppColors.light.onTertiary,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.light.onSurface,
          side: BorderSide(color: AppColors.light.outline),
        ),
      ),
    );
  }

  /// Dark theme based on [ThemeData.dark] with Material 3 and app [ColorScheme].
  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      colorScheme: AppColors.dark,
      scaffoldBackgroundColor: AppColors.dark.surface,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.dark.surface,
        foregroundColor: AppColors.dark.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.dark.surface,
        selectedItemColor: AppColors.tertiary,
        unselectedItemColor: AppColors.dark.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: CardThemeData(
        color: AppColors.dark.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.tertiary,
          foregroundColor: AppColors.dark.onTertiary,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.dark.onSurface,
          side: BorderSide(color: AppColors.dark.outline),
        ),
      ),
    );
  }
}
