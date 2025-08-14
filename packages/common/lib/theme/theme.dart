import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part '_colors_theme.dart';
part '_theme_extensions.dart';

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.w),
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: colorScheme.primary,
    ),
  );
}
