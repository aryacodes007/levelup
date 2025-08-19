import 'package:common/common.dart';
import 'package:flutter/material.dart';

/// RequiredFieldExtension: Adds a required asterisk (*) to [Text] widgets.
///
/// This extension provides two ways to mark a [Text] widget as required:
///
/// 1. **Static required**: Use the `.required` getter to always display an asterisk.
/// 2. **Dynamic required**: Use `.isRequired(bool show)` to conditionally display
///    an asterisk based on a runtime boolean value.
///
/// Features:
/// - The asterisk (*) is styled using the theme's `colorScheme.error`.
/// - Determines the color based on the current system [Brightness] (dark/light mode)
///   without requiring a [BuildContext].
/// - Preserves the original [Text.style] for consistency.
/// - Returns the original [Text] widget when the field is not required to avoid
///   unnecessary widget creation and improve performance.
///
/// [Example] usage:
/// Text('Amount').required;          // Always shows "*"
/// Text('Amount').isRequired(true);  // Shows "*" dynamically
/// Text('Amount').isRequired(false); // Plain text without "*"
extension RequiredFieldExtension on Text {
  /// Always shows asterisk (*)
  Widget get required => _buildAsterisk(true);

  /// Shows asterisk based on dynamic boolean
  Widget isRequired(bool show) => _buildAsterisk(show);

  Widget _buildAsterisk(bool show) {
    if (!show) return this; // Return original Text if not required

    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    final errorColor = brightness == Brightness.dark
        ? darkTheme.colorScheme.error
        : lightTheme.colorScheme.error;

    return RichText(
      text: TextSpan(
        text: data ?? '',
        style: style,
        children: [
          TextSpan(
            text: '*',
            style: style?.copyWith(
              color: errorColor,
            ),
          ),
        ],
      ),
    );
  }
}
