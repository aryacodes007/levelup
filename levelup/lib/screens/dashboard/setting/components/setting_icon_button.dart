import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A custom icon button styled for settings screens.
///
/// Features:
/// - [icon]: The widget to display inside the button (usually an `Icon`).
/// - [splashColor]: The foreground/splash color applied when pressed.
/// - [onPressed]: The callback triggered on tap.
///
/// Differences from the default [IconButton]:
/// - Uses `VisualDensity.minimumDensity` for a more compact appearance.
/// - Adds custom padding around the icon for consistent spacing.
/// - Allows flexible icon widgets (not just `Icon`).
class SettingIconButton extends StatelessWidget {
  final Widget icon;
  final Color splashColor;
  final VoidCallback onPressed;

  const SettingIconButton({
    super.key,
    required this.icon,
    required this.splashColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        visualDensity: VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        padding: EdgeInsets.zero,
        foregroundColor: splashColor,
      ),
      onPressed: onPressed,
      icon: Padding(
        padding: EdgeInsets.all(8.w),
        child: icon,
      ),
    );
  }
}
