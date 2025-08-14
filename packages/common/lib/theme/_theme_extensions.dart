part of 'theme.dart';

/// This class [defines] the custom [colors] used in the LevelUp app.
class AppColors extends ThemeExtension<AppColors> {
  final Color background; // Background / Surface color
  final Color primaryText; // OnSurface text color
  final Color accent1; // Primary (Muted teal)
  final Color accent2; // Tertiary (Warm pink)
  final Color button; // Secondary (Muted lavender)

  const AppColors({
    required this.background,
    required this.primaryText,
    required this.accent1,
    required this.accent2,
    required this.button,
  });

  @override
  AppColors copyWith() {
    // We don't use copyWith for the moment
    // Colors are not well defined enough to maintain this
    throw UnimplementedError();
  }

  @override
  ThemeExtension<AppColors> lerp(
      ThemeExtension<AppColors>? other,
      double t,
      ) {
    // We don't use colors lerp for the moment
    // Colors are not well defined enough to maintain this
    if (other == null) return this;

    return t < .5 ? this : other;
  }
}

/// Default Light Theme colors for LevelUp.
const AppColors appColorsExtensionLight = AppColors(
  background: Color(0xFFFFFFFF), // White background
  primaryText: Color(0xFF2C2C2C), // Slate gray text
  accent1: Color(0xFF007B83), // Muted teal
  accent2: Color(0xFFFF6F84), // Warm pink
  button: Color(0xFF8E6FC1), // Muted lavender
);

/// Default Dark Theme colors for LevelUp.
const AppColors appColorsExtensionDark = AppColors(
  background: Color(0xFF2C2C2C), // Slate gray
  primaryText: Color(0xFFE4E4E4), // Light gray
  accent1: Color(0xFFA8DADC), // Light cyan
  accent2: Color(0xFFFFC1CC), // Soft pink
  button: Color(0xFFB39CD0), // Lavender
);

/// Extensions for AppColors on ThemeData.
extension AppColorsExtensions on ThemeData {
  AppColors get appColors => extension<AppColors>()!;
}
