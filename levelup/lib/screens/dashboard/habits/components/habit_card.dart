import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:levelup/levelup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// UI widget representing a single habit item in the habit list.
///
/// Responsibilities:
/// - Displays habit details (emoji, title, current streak).
/// - Provides swipe actions for delete (➡️) and edit (⬅️) via [Dismissible].
/// - Shows a checkbox to toggle today’s completion, triggering confetti on success.
/// - Integrates with [ConfettiControllersNotifier] for celebratory effects.
///
/// Notes:
/// - [habitId] uniquely identifies the habit and ties to its confetti controller.
/// - [onToggle], [onEdit], and [onDelete] callbacks handle user interactions.
/// - Uses [EmojiView] for rendering the habit’s emoji with a colored background.
/// - Streak display dynamically includes the streak emoji via [streakEmojiProvider].
class HabitCard extends ConsumerWidget {
  final String habitId;
  final String title;
  final String emoji;
  final int colorValue;
  final int currentStreak;
  final bool doneToday;
  final VoidCallback onToggle;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const HabitCard({
    super.key,
    required this.habitId,
    required this.title,
    this.emoji = AppConst.defaultEmoji,
    required this.colorValue,
    required this.currentStreak,
    required this.doneToday,
    required this.onToggle,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).appColors;
    final appLocal = context.l10n;

    final selectedColor = Color(colorValue);
    final confetti =
        ref.read(confettiControllersProvider.notifier).getController(habitId);

    return Stack(
      children: [
        Card(
          elevation: 1.2.w,
          shadowColor: selectedColor,
          child: Dismissible(
            key: ValueKey(habitId),
            dismissThresholds: {
              DismissDirection.startToEnd: 0.2,
              DismissDirection.endToStart: 0.2,
            },
            background: _dismissibleBackground(
              context: context,
              isDelete: true,
            ),
            secondaryBackground: _dismissibleBackground(
              context: context,
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                onEdit?.call();
              } else if (direction == DismissDirection.startToEnd) {
                onDelete?.call();
              }
              return false;
            },
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.w),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              leading: EmojiView(
                size: 40,
                emojiSize: 16,
                color: selectedColor,
                emoji: emoji,
              ),
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Consumer(
                builder: (context, ref, child) {
                  final streakEmoji = ref.watch(streakEmojiProvider);

                  return RichText(
                    text: TextSpan(
                      text: appLocal.streak,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: colors.primaryText,
                      ),
                      children: [
                        TextSpan(
                          text: '$currentStreak $streakEmoji',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: colors.primaryText,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              trailing: Transform.scale(
                scale: 1.2.w,
                child: Checkbox(
                  value: doneToday,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  side: BorderSide(
                    color: selectedColor,
                    width: 1.6.w,
                  ),
                  checkColor: lightTheme.colorScheme.onPrimary,
                  fillColor: WidgetStateProperty.resolveWith(
                    (states) {
                      if (states.contains(WidgetState.selected)) {
                        return selectedColor;
                      }
                      return null;
                    },
                  ),
                  onChanged: (_) => _onHabit(confetti),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 40.w),
                child: ConfettiWidget(
                  confettiController: confetti,
                  blastDirectionality: BlastDirectionality.explosive,
                  numberOfParticles: 50,
                  maxBlastForce: 14.w,
                  minBlastForce: 2.w,
                  emissionFrequency: 0.001,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onHabit(ConfettiController confetti) {
    onToggle();
    if (!doneToday) confetti.play();
  }

  Container _dismissibleBackground({
    required BuildContext context,
    bool isDelete = false,
  }) {
    final colors = Theme.of(context).appColors;

    final alignment = isDelete ? Alignment.centerLeft : Alignment.centerRight;
    final padding = isDelete
        ? EdgeInsets.only(
            left: 16.w,
          )
        : EdgeInsets.only(
            right: 16.w,
          );
    final color = isDelete ? lightTheme.colorScheme.error : colors.accent1;
    final icon = isDelete ? Icons.delete : Icons.edit;

    return Container(
      alignment: alignment,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Icon(
        icon,
        color: lightTheme.colorScheme.onPrimary,
      ),
    );
  }
}
