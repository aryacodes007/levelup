import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:levelup/levelup.dart';
import 'package:intl/intl.dart';

/// Main screen that displays the list of user habits.
///
/// Features:
/// - Shows a list of [HabitCard]s with streak count, completion state, and emoji/color.
/// - Allows toggling habit completion for today.
/// - Provides editing and deletion of habits with confirmation dialogs.
/// - Animated entry of each habit card for smooth UX.
/// - Displays an empty state message when no habits exist.
/// - Floating Action Button (FAB) to add a new habit.
///
/// State Management:
/// - Consumes [habitsProvider] (Riverpod) for live habit list updates.
/// - Uses [habitRepositoryProvider] to calculate streaks.
///
/// Navigation & Dialogs:
/// - [_openHabitPopup] opens the [AddHabitScreen] in an animated dialog.
/// - [_deleteHabit] confirms deletion with a dialog and shows a success animation.
class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);
    final colors = Theme.of(context).appColors;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openHabitPopup(
          context: context,
        ),
        child: Icon(
          Icons.add,
          size: 30.w,
        ),
      ),
      body: Stack(
        children: [
          // Animated Habits background
          HabitsBackground(),

          // Habits
          SafeArea(
            child: habits.isEmpty
                ? Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      context.l10n.noHabitsYet,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    itemCount: habits.length + 1,
                    shrinkWrap: true,
                    addRepaintBoundaries: true,
                    addAutomaticKeepAlives: true,
                    itemBuilder: (context, index) {
                      if (index == habits.length) {
                        return SizedBox(height: 70.h);
                      }

                      final habit = habits[index];
                      final doneToday = habit.completionByDate[
                              DateFormat(AppConst.dateFormat).format(
                            DateTime.now(),
                          )] ??
                          false;

                      final streak = ref
                          .read(habitRepositoryProvider)
                          .computeCurrentStreak(habit);

                      return TweenAnimationBuilder(
                        key: ValueKey(habit.id),
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, (1 - value) * 50),
                              child: child,
                            ),
                          );
                        },
                        child: HabitCard(
                          habitId: habit.id,
                          title: habit.title,
                          emoji: habit.emoji,
                          colorValue: habit.colorValue,
                          currentStreak: streak,
                          doneToday: doneToday,
                          onToggle: () =>
                              ref.read(habitsProvider.notifier).toggleDone(
                                    habit.id,
                                  ),
                          onEdit: () => _openHabitPopup(
                            context: context,
                            editHabit: habit,
                          ),
                          onDelete: () => _deleteHabit(
                            context: context,
                            ref: ref,
                            habit: habit,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteHabit({
    required BuildContext context,
    required WidgetRef ref,
    required Habit habit,
  }) async {
    final appLocal = context.l10n;

    final isDeleted = await DialogUtils.showDeleteAlertDialog(
      context: context,
      title: appLocal.sayGoodbyeTo,
      message: appLocal.deletingWillErase,
      deleteText: appLocal.delete,
      cancelText: appLocal.cancel,
      onDelete: () => context.pop(true),
      onCancel: () => context.pop(),
    );

    if (isDeleted == true) {
      ref.read(habitsProvider.notifier).deleteHabit(habit.id);
      DialogUtils.showDeleteSuccessDialog(
        context: context,
        asset: 'assets/lottie/success.json',
        message: appLocal.deletedHabitSuccess,
        onLoaded: context.pop,
      );
    }
  }

  void _openHabitPopup({
    required BuildContext context,
    Habit? editHabit,
  }) {
    DialogUtils.showAnimatedDialog(
      context: context,
      pageBuilder: (
        context,
        a,
        b,
      ) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 350.w,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: AddHabitScreen(editHabit: editHabit),
            ),
          ),
        );
      },
    );
  }
}
