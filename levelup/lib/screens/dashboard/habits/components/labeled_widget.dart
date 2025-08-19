import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
