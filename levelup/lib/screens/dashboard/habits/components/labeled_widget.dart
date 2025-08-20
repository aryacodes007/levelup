import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable widget that displays a labeled [child] widget with an optional
/// "required" indicator.
///
/// Usage:
/// - Commonly used in forms or input fields to display a label above the widget.
/// - Supports marking the label as required by setting [isRequired] to true.
///
/// Parameters:
/// - [title]: The label text displayed above the child.
/// - [child]: The widget being labeled (e.g., TextField, Dropdown, etc.).
/// - [isRequired]: If true, adds a visual indicator (e.g., asterisk) to show
/// the field is required.
class LabeledWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isRequired;

  const LabeledWidget({
    super.key,
    required this.title,
    required this.child,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title - Text
        Text(
          title,
          style: TextStyle(
            fontSize: 15.sp,
            color: colors.accent1,
            fontWeight: FontWeight.w500,
          ),
        ).isRequired(isRequired),

        // Child - Widget
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: child,
        ),
      ],
    );
  }
}
