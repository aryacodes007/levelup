import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:levelup/levelup.dart';

/// UI widget for displaying a habit’s emoji inside a styled container.
///
/// Responsibilities:
/// - Renders an emoji with configurable size, background color, and shadow.
/// - Falls back to a tappable area (via [pickColor]) if no emoji is set.
/// - Adapts styling to theme colors using [Theme.appColors].
///
/// Notes:
/// - [size] controls the container size; [emojiSize] controls the emoji font size.
/// - If [color] is null but [emoji] is not empty, a border is shown instead of a background.
/// - When no emoji is provided, an [InkWell] placeholder is shown for interaction.

class EmojiView extends StatelessWidget {
  final String emoji;
  final Color? color;
  final double size;
  final double emojiSize;
  final void Function()? pickColor;

  const EmojiView({
    super.key,
    this.emoji = '',
    this.color,
    this.size = 60,
    this.emojiSize = 24,
    this.pickColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;

    return Container(
      height: size.w,
      width: size.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: color?.withAlpha(0.95.opacity),
        border: emoji.isNotEmpty && color == null
            ? Border.all(
                color: colors.primaryText,
              )
            : null,
        boxShadow: [
          if (color != null)
            BoxShadow(
              color: color!.withAlpha(0.8.opacity),
              offset: const Offset(1, 2),
              blurRadius: 5.w,
            ),
        ],
      ),
      child: emoji.isNotEmpty
          ? Text(
              emoji,
              style: TextStyle(
                fontSize: emojiSize.sp,
              ),
            )
          : Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: pickColor,
                borderRadius: BorderRadius.circular(50.w),
              ),
            ),
    );
  }
}
