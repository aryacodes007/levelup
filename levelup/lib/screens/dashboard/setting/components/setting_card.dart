import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:levelup/levelup.dart';

/// A reusable settings card widget used in the Settings screen.
///
/// Displays:
/// - A [title] as the main label.
/// - A [subTitle] for additional context or description.
/// - A [child] widget (usually a switch, dropdown, or icon) aligned to the trailing side.
///
/// Usage:
/// Typically used to represent a single configurable setting,
/// such as theme mode toggle, language selection, or notification preferences.
class SettingCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget child;

  const SettingCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;

    return Card(
      shadowColor: colors.primaryText,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subTitle,
        ),
        trailing: child,
      ),
    );
  }
}
