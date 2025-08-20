import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part '_colors_theme.dart';
part '_theme_extensions.dart';

/// Application Themes
///
/// Defines the light and dark [ThemeData] configurations for the app.
/// Uses [Material 3] principles and extends Flutter's theming system
/// with custom [ColorScheme] and [ThemeExtension].
///
/// Provides:
/// - Light theme → [lightTheme]
/// - Dark theme → [darkTheme]
/// - Centralized builder → [buildTheme] for reusability
///
/// Customizations include:
/// - Primary color & surface background
/// - AppBar styling
/// - NavigationBar icon & label behavior
/// - Dialog, Radio, Checkbox, and Button themes
/// - Icon color and shape definitions
final lightTheme = buildTheme(_colorSchemeLight, appColorsExtensionLight);
final darkTheme = buildTheme(_colorSchemeDark, appColorsExtensionDark);

ThemeData buildTheme(ColorScheme colorScheme, ThemeExtension<dynamic> colors) {
  return ThemeData(
    extensions: [colors],
    useMaterial3: true,
    primaryColor: colorScheme.primary,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: colorScheme.onSurface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      surfaceTintColor: colorScheme.secondary,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: colorScheme.surface,
      indicatorColor: colorScheme.surface,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      iconTheme: WidgetStateProperty.resolveWith((state) {
        return IconThemeData(
          color: state.contains(WidgetState.selected)
              ? colorScheme.primary
              : colorScheme.secondary,
        );
      }),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surface,
    ),
    radioTheme: const RadioThemeData(
      visualDensity: VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((state) {
        return state.contains(WidgetState.selected)
            ? colorScheme.primary
            : colorScheme.surface;
      }),
      checkColor: WidgetStateProperty.all(
        colorScheme.onPrimary,
      ),
      side: BorderSide(
        color: colorScheme.primary,
        width: 1.5.w,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: EdgeInsets.symmetric(
          vertical: 12.sp,
        ),
        enableFeedback: false,
        visualDensity: VisualDensity(
          vertical: VisualDensity.minimumDensity,
          horizontal: VisualDensity.minimumDensity,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.w),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: EdgeInsets.symmetric(
          vertical: 12.sp,
        ),
        enableFeedback: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: colorScheme.primary,
    ),
  );
}
