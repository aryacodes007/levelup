import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// [TypewriterText]
/// A simple widget that animates multi-line text like a typewriter.
/// - Each character fades in one by one.
/// - Multiple lines are supported using '\n'.
/// - The next line starts only after the previous line finishes.
///
/// [text]: The string to animate. Can include '\n' for multiple lines.
/// [style]: TextStyle for the text.
/// [delayMs]: Delay between each character in milliseconds (default 100ms).
class TypewriterText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int delayMs;

  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.delayMs = 100,
  });

  @override
  Widget build(BuildContext context) {
    // Split the text into separate lines using '\n'
    final lines = text.split('\n');

    // Keep track of how many characters have been animated so far
    int cumulativeChars = 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: lines.map((line) {
        final lineLength = line.length;

        // Create a row for each line
        final row = Row(
          mainAxisSize: MainAxisSize.min,
          children: line.split('').asMap().entries.map((entry) {
            final charIndex = entry.key;
            final char = entry.value;

            // Calculate delay based on previous characters + current character
            final delay = Duration(
              milliseconds: delayMs * (cumulativeChars + charIndex),
            );

            // Animate each character
            return Text(char, style: style).animate().fade(
                  duration: 100.ms,
                  delay: delay,
                );
          }).toList(),
        );

        // Update cumulativeChars so the next line starts after this line finishes
        cumulativeChars += lineLength;

        return row;
      }).toList(),
    );
  }
}
