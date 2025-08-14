part of 'theme.dart';

/// A class containing custom light colors for the [LevelUp] app.
abstract class _AppColorsLight {
  static const Color primary = Color(0xFF007B83);    // Accent 1 (Muted teal)
  static const Color onPrimary = Color(0xFFFFFFFF);  // White text
  static const Color surface = Color(0xFFFFFFFF);    // Background white
  static const Color onSurface = Color(0xFF2C2C2C);  // Slate gray text
  static const Color secondary = Color(0xFF8E6FC1);  // Button/CTA (Muted lavender)
  static const Color onSecondary = Color(0xFFFFFFFF);// White text
  static const Color tertiary = Color(0xFFFF6F84);   // Accent 2 (Warm pink)
  static const Color onTertiary = Color(0xFFFFFFFF); // White text
  static const Color error = Color(0xFFF71829);      // Error red
  static const Color onError = Color(0xFFFFFFFF);    // White text
}

///A class containing custom colors for the [LevelUp] app.
abstract class _AppColorsDark {
  static const Color primary = Color(0xFFA8DADC); // Accent 1
  static const Color onPrimary = Color(0xFF2C2C2C); // Background
  static const Color surface = Color(0xFF2C2C2C); // Background
  static const Color onSurface = Color(0xFFE4E4E4); // Primary text
  static const Color secondary = Color(0xFFB39CD0); // Button/CTA
  static const Color onSecondary = Color(0xFF2C2C2C); // Background
  static const Color tertiary = Color(0xFFFFC1CC); // Accent 2
  static const Color onTertiary = Color(0xFF2C2C2C); // Background
  static const Color error = Color(0xFFF71829);
  static const Color onError = Color(0xFFFFFFFF);
}

/// Light color scheme
const _colorSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: _AppColorsLight.primary,
  onPrimary: _AppColorsLight.onPrimary,
  secondary: _AppColorsLight.secondary,
  onSecondary: _AppColorsLight.onSecondary,
  tertiary: _AppColorsLight.tertiary,
  onTertiary: _AppColorsLight.onTertiary,
  error: _AppColorsLight.error,
  onError: _AppColorsLight.onError,
  surface: _AppColorsLight.surface,
  onSurface: _AppColorsLight.onSurface,
);

/// Dark color scheme
const _colorSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: _AppColorsDark.primary,
  onPrimary: _AppColorsDark.onPrimary,
  secondary: _AppColorsDark.secondary,
  onSecondary: _AppColorsDark.onSecondary,
  tertiary: _AppColorsDark.tertiary,
  onTertiary: _AppColorsDark.onTertiary,
  error: _AppColorsDark.error,
  onError: _AppColorsDark.onError,
  surface: _AppColorsDark.surface,
  onSurface: _AppColorsDark.onSurface,
);
