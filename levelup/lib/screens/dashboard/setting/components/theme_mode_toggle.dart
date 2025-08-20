import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:levelup/levelup.dart';

/// A custom toggle widget to switch between [ThemeMode.system],
/// [ThemeMode.light], and [ThemeMode.dark].
///
/// Features:
/// - Animated circular indicator that moves to the selected mode.
/// - Smooth scale animation on active icon.
/// - Uses `InkWell` with ripple/sparkle splash effect for interaction.
/// - Fully responsive (uses `.w` for sizing).
class ThemeModeToggle extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onChanged;

  const ThemeModeToggle({
    super.key,
    required this.themeMode,
    required this.onChanged,
  });

  Alignment get _alignment => switch (themeMode) {
        ThemeMode.system => Alignment.centerLeft,
        ThemeMode.light => Alignment.center,
        ThemeMode.dark => Alignment.centerRight,
      };

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;

    return SizedBox(
      width: 100.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated circle indicator
          AnimatedAlign(
            duration: Durations.medium2,
            curve: Curves.easeOutBack,
            alignment: _alignment,
            child: Container(
              width: 35.w,
              height: 35.w,
              decoration: BoxDecoration(
                color: colors.accent1,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.accent1.withAlpha(
                      0.30.opacity,
                    ),
                    blurRadius: 5.w,
                    spreadRadius: 1.w,
                  ),
                ],
              ),
            ),
          ),

          // Icons row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              children: [
                // System
                _buildModeButton(
                  context,
                  icon: Icons.brightness_auto,
                  selected: themeMode == ThemeMode.system,
                  onTap: () => onChanged(ThemeMode.system),
                ),

                // Light
                _buildModeButton(
                  context,
                  icon: Icons.light_mode,
                  selected: themeMode == ThemeMode.light,
                  onTap: () => onChanged(ThemeMode.light),
                ),

                // Dark
                _buildModeButton(
                  context,
                  icon: Icons.dark_mode,
                  selected: themeMode == ThemeMode.dark,
                  onTap: () => onChanged(ThemeMode.dark),
                ),
              ]
                  .map(
                    (widget) => Expanded(child: widget),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Private builder method for mode button
  Widget _buildModeButton(
    BuildContext context, {
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? colors.primaryText : colors.primaryText;
    final activeColor = colors.background;

    return InkWell(
      onTap: onTap,
      splashFactory: InkSparkle.splashFactory,
      borderRadius: BorderRadius.circular(50.w),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: AnimatedScale(
          scale: selected ? 1.1 : 1.0,
          duration: Durations.medium2,
          curve: Curves.easeOut,
          child: Icon(
            icon,
            size: 22.w,
            color: selected ? activeColor : baseColor,
          ),
        ),
      ),
    );
  }
}
