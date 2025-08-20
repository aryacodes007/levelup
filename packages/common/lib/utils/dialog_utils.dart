import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

/// [DialogUtils]
///
/// A utility class that provides reusable dialog methods with animations.
///
/// Includes:
/// - [showAnimatedDialog] → Base method to show dialogs with scale + fade transitions.
/// - [showDeleteAlertDialog] → Confirmation dialog for delete actions with custom actions.
/// - [showDeleteSuccessDialog] → Success dialog with Lottie animation.
/// - [_textButton] → Internal helper for styled dialog action buttons.
///
/// This ensures all dialogs in the app are consistent in appearance and behavior.
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
    required String deleteText,
    required String cancelText,
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
              text: cancelText,
              textColor: colors.primaryText,
              onPressed: onCancel,
            ),
            _textButton(
              text: deleteText,
              textColor: colorScheme.error,
              onPressed: onDelete,
            ),
          ],
        );
      },
    );
  }

  static void showDeleteSuccessDialog({
    required BuildContext context,
    required String asset,
    required String message,
    required VoidCallback onLoaded,
  }) {
    DialogUtils.showAnimatedDialog(
      context: context,
      pageBuilder: (context, a, b) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 300.w,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    asset,
                    repeat: false,
                    frameRate: FrameRate.max, // ensure max available frames
                    onLoaded: (composition) {
                      Future.delayed(composition.duration, () {
                        onLoaded.call();
                      });
                    },
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
