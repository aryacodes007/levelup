import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogUtils {
  static Future<T?> showAnimatedDialog<T extends Object?>({
    required BuildContext context,
    required Widget Function(BuildContext, Animation, Animation) pageBuilder,
  }) async {
    return showGeneralDialog(
      context: context,
      transitionDuration: Durations.medium2,
      transitionBuilder: (_, animate, __, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animate,
            curve: Curves.easeOutBack,
          ),
          child: FadeTransition(
            opacity: animate,
            child: child,
          ),
        );
      },
      pageBuilder: pageBuilder,
    );
  }

  static Future<bool?> showDeleteAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    required void Function() onDelete,
    required void Function() onCancel,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).appColors;

    return showAnimatedDialog<bool?>(
      context: context,
      pageBuilder: (context, a, b) {
        return AlertDialog(
          backgroundColor: colors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colorScheme.error,
              fontSize: 18.sp,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          actions: [
            _textButton(
              text: 'Cancel',
              textColor: colors.primaryText,
              onPressed: onCancel,
            ),
            _textButton(
              text: 'Delete',
              textColor: colorScheme.error,
              onPressed: onDelete,
            ),
          ],
        );
      },
    );
  }

  static TextButton _textButton({
    required String text,
    required Color textColor,
    required void Function() onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: textColor,
        padding: EdgeInsets.all(10.w),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
