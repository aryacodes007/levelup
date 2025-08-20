import 'dart:developer';
import 'package:common/common.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// [ServiceUtils]
///
/// A utility class that provides common service-level helpers used across the app.
///
/// Features:
/// - [keyboardClosed] → Closes the software keyboard if open.
/// - [showEmojiKeyboard] → Displays an emoji picker bottom sheet and returns the selected emoji.
/// - [logs] → Logs messages in debug mode (no-ops in release).
class ServiceUtils {
  // Closes the keyboard if it's open.
  static void keyboardClosed() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // Show emoji keyboard
  static Future<void> showEmojiKeyboard({
    required BuildContext context,
    required void Function(String emoji) onEmojiSelected,
  }) async {
    String? emojiSelected = await showModalBottomSheet(
      context: context,
      builder: (context) {
        final colors = Theme.of(context).appColors;
        return SizedBox(
          height: 280.h,
          child: EmojiPicker(
            onEmojiSelected: (category, emoji) => Navigator.pop(
              context,
              emoji.emoji,
            ),
            config: Config(
              emojiViewConfig: EmojiViewConfig(
                emojiSizeMax: 25.w, // max emoji size
                columns: 8, // set number of columns here
                backgroundColor: colors.background,
              ),
              searchViewConfig: SearchViewConfig(
                buttonIconColor: colors.primaryText,
                backgroundColor: colors.background,
              ),
              bottomActionBarConfig: BottomActionBarConfig(
                backgroundColor: colors.accent1,
                buttonIconColor: colors.background,
                buttonColor: colors.accent1,
              ),
              categoryViewConfig: CategoryViewConfig(
                backgroundColor: colors.accent1,
                iconColor: colors.background.withAlpha(
                  0.6.opacity,
                ),
                iconColorSelected: colors.background,
                backspaceColor: colors.background,
                indicatorColor: colors.background,
              ),
            ),
          ),
        );
      },
    );

    if (emojiSelected != null) {
      onEmojiSelected(emojiSelected);
    }
  }

  // Logs a message.
  static void logs(String message) => kReleaseMode ? {} : log(message);
}
