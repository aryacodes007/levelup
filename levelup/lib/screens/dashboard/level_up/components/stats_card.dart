import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:levelup/levelup.dart';

/// [StatsCard]
///
/// A card widget displaying a single statistic in the dashboard or summary view.
///
/// Features:
/// - Shows a [title] describing the statistic.
/// - Displays the [value] prominently with the accent color ([colors.accent1]).
/// - Shows the [subtitle] next to the value in smaller, muted text ([colors.primaryText]).
/// - Uses [RichText] to combine value and subtitle styling.
/// - Stateless and purely presentational, intended for dashboards or summary lists.
class StatsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;

  const StatsCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;

    return Card(
      shadowColor: colors.primaryText,
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 6.h,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
            RichText(
              text: TextSpan(
                text: '$value ',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: colors.accent1,
                ),
                children: [
                  TextSpan(
                    text: subtitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: colors.primaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
