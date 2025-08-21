import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:levelup/levelup.dart';

/// [BestHabitCard]
///
/// A card widget displaying a single habit in the "Best Habits" list.
///
/// Features:
/// - Shows the habit's emoji ([habit.emoji]) and title ([habit.title]) on the left.
/// - Shows the habit's best streak ([habit.bestStreak]) with the global streak emoji
///   ([streakEmojiProvider]) on the right.
/// - Applies the habit's color ([habit.colorValue]) as the card shadow.
/// - Uses [RichText] for combined text styling of emoji/title and streak/emoji.
/// - Stateless and relies on [Consumer] to watch the [streakEmojiProvider].
class BestHabitCard extends StatelessWidget {
  final Habit habit;

  const BestHabitCard({
    super.key,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;
    final color = Color(habit.colorValue);

    return Card(
      shadowColor: color,
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Habit Emoji and Title
            _richText(
              text: habit.emoji,
              text2: habit.title,
              textColor: colors.primaryText,
            ),

            // Best Streak and Streak Emoji
            Consumer(
              builder: (context, ref, child) {
                final streakEmoji = ref.watch(streakEmojiProvider);

                return _richText(
                  text: habit.bestStreak.toString(),
                  text2: streakEmoji,
                  textColor: colors.primaryText,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  RichText _richText({
    required String text,
    required String text2,
    required Color textColor,
  }) {
    return RichText(
      text: TextSpan(
        text: '$text ',
        style: TextStyle(
          fontSize: 15.sp,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
