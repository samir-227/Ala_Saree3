import 'package:flutter/material.dart';

/// Centralized brand and semantic colors for the app.
/// Use [AppColors.light] and [AppColors.dark] to build [ColorScheme] and themes.
/// Extend this class with new static colors or palettes as needed.
abstract final class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // Brand palette (shared across light/dark)
  // ---------------------------------------------------------------------------

  /// Primary brand color (e.g. navigation, primary actions).
  static const Color primary = Color(0xFFDA291C);

  /// Secondary brand color (e.g. splash, highlights).
  static const Color secondary = Color(0xFFFEB60D);

  /// Tertiary accent (e.g. CTAs, success feedback).
  static const Color tertiary = Color(0xFFE65100);

  /// Success / positive feedback background.
  static const Color successBackground = Color(0xFFFFE8D9);

  /// Success / positive feedback foreground.
  static const Color successForeground = Color(0xFFCC6A2F);

  // ---------------------------------------------------------------------------
  // Light theme palette
  // ---------------------------------------------------------------------------

  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightSurfaceVariant = Color(0xFFEEEEEE);
  static const Color _lightSurfaceDim = Color(0xFFE8E8E8);
  static const Color _lightSurfaceContainerLow = Color(0xFFF5F5F5);
  static const Color _lightOnPrimary = Color(0xFFFFFFFF);
  static const Color _lightOnSecondary = Color(0xFF1C1C1C);
  static const Color _lightOnTertiary = Color(0xFFFFFFFF);
  static const Color _lightOnSurface = Color(0xFF1C1C1C);
  static const Color _lightOnSurfaceVariant = Color(0xFF5C5C5C);
  static const Color _lightOutline = Color(0xFFE0E0E0);
  static const Color _lightOutlineVariant = Color(0xFFBDBDBD);
  static const Color _lightError = Color(0xFFB00020);
  static const Color _lightOnError = Color(0xFFFFFFFF);
  static const Color _lightInverseSurface = Color(0xFF1C1C1C);
  static const Color _lightInverseOnSurface = Color(0xFFF5F5F5);
  static const Color _lightInversePrimary = Color(0xFFFFB4AB);
  static const Color _lightShadow = Color(0xFF000000);
  static const Color _lightScrim = Color(0xFF000000);

  /// Light theme [ColorScheme] built from brand and light-specific colors.
  static ColorScheme get light => ColorScheme.light(
    primary: primary,
    onPrimary: _lightOnPrimary,
    primaryContainer: primary.withValues(alpha: 0.12),
    onPrimaryContainer: primary,
    secondary: secondary,
    onSecondary: _lightOnSecondary,
    secondaryContainer: secondary.withValues(alpha: 0.25),
    onSecondaryContainer: const Color(0xFF5C3D00),
    tertiary: tertiary,
    onTertiary: _lightOnTertiary,
    tertiaryContainer: tertiary.withValues(alpha: 0.2),
    onTertiaryContainer: tertiary,
    error: _lightError,
    onError: _lightOnError,
    errorContainer: _lightError.withValues(alpha: 0.15),
    onErrorContainer: _lightError,
    surface: _lightSurface,
    onSurface: _lightOnSurface,
    surfaceContainerHighest: _lightSurfaceVariant,
    onSurfaceVariant: _lightOnSurfaceVariant,
    outline: _lightOutline,
    outlineVariant: _lightOutlineVariant,
    inverseSurface: _lightInverseSurface,
    onInverseSurface: _lightInverseOnSurface,
    inversePrimary: _lightInversePrimary,
    shadow: _lightShadow,
    scrim: _lightScrim,
    surfaceDim: _lightSurfaceDim,
    surfaceBright: _lightSurface,
    surfaceContainerLowest: _lightSurface,
    surfaceContainerLow: _lightSurfaceContainerLow,
    surfaceContainer: _lightSurfaceVariant,
  );

  // ---------------------------------------------------------------------------
  // Dark theme palette
  // ---------------------------------------------------------------------------

  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkSurfaceVariant = Color(0xFF2C2C2C);
  static const Color _darkOnPrimary = Color(0xFFFFFFFF);
  static const Color _darkOnSecondary = Color(0xFF1C1C1C);
  static const Color _darkOnTertiary = Color(0xFFFFFFFF);
  static const Color _darkOnSurface = Color(0xFFE8E8E8);
  static const Color _darkOnSurfaceVariant = Color(0xFFBDBDBD);
  static const Color _darkOutline = Color(0xFF424242);
  static const Color _darkOutlineVariant = Color(0xFF616161);
  static const Color _darkError = Color(0xFFCF6679);
  static const Color _darkOnError = Color(0xFF1C1C1C);
  static const Color _darkInverseSurface = Color(0xFFE8E8E8);
  static const Color _darkInverseOnSurface = Color(0xFF1C1C1C);
  static const Color _darkInversePrimary = Color(0xFF8B1C12);
  static const Color _darkShadow = Color(0xFF000000);
  static const Color _darkScrim = Color(0xFF000000);

  /// Dark theme [ColorScheme] built from brand and dark-specific colors.
  static ColorScheme get dark => ColorScheme.dark(
    primary: primary,
    onPrimary: _darkOnPrimary,
    primaryContainer: primary.withValues(alpha: 0.25),
    onPrimaryContainer: _lightInversePrimary,
    secondary: secondary,
    onSecondary: _darkOnSecondary,
    secondaryContainer: secondary.withValues(alpha: 0.25),
    onSecondaryContainer: secondary,
    tertiary: tertiary,
    onTertiary: _darkOnTertiary,
    tertiaryContainer: tertiary.withValues(alpha: 0.3),
    onTertiaryContainer: const Color(0xFFFFCC80),
    error: _darkError,
    onError: _darkOnError,
    errorContainer: _darkError.withValues(alpha: 0.2),
    onErrorContainer: _darkError,
    surface: _darkSurface,
    onSurface: _darkOnSurface,
    surfaceContainerHighest: _darkSurfaceVariant,
    onSurfaceVariant: _darkOnSurfaceVariant,
    outline: _darkOutline,
    outlineVariant: _darkOutlineVariant,
    inverseSurface: _darkInverseSurface,
    onInverseSurface: _darkInverseOnSurface,
    inversePrimary: _darkInversePrimary,
    shadow: _darkShadow,
    scrim: _darkScrim,
    surfaceDim: _darkBackground,
    surfaceBright: _darkSurfaceVariant,
    surfaceContainerLowest: _darkBackground,
    surfaceContainerLow: _darkSurface,
    surfaceContainer: _darkSurfaceVariant,
  );

  // ---------------------------------------------------------------------------
  // Semantic / convenience (theme-agnostic)
  // ---------------------------------------------------------------------------

  /// Transparent color for overlays or “no fill”.
  static const Color transparent = Colors.transparent;

  /// Neutral grey for disabled or de-emphasized content (light theme).
  static const Color greyLight = Color(0xFF9E9E9E);

  /// Neutral grey for disabled or de-emphasized content (dark theme).
  static const Color greyDark = Color(0xFF757575);

  /// Decorative backgrounds for payment card preview (e.g. in add card screen).
  static const List<Color> cardPreviewBackgrounds = [
    Color(0xFF141414),
    Color(0xFF26374D),
    Color(0xFF5B2C6F),
  ];
}
