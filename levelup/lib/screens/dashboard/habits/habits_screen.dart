import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:levelup/levelup.dart';
import 'package:intl/intl.dart';

class HabitsScreen extends ConsumerStatefulWidget {
  const HabitsScreen({super.key});

  @override
  ConsumerState<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends ConsumerState<HabitsScreen> {
  @override
  Widget build(BuildContext context) {
    final habits = ref.watch(habitsProvider);

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
      body: SafeArea(
        child: habits.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No habits yet. Tap + to add one.',
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                itemCount: habits.length + 1,
                shrinkWrap: true,
                addRepaintBoundaries: true,
                addAutomaticKeepAlives: true,
                itemBuilder: (context, index) {
                  if (index == habits.length) {
                    return SizedBox(height: 70.h);
                  }

                  final h = habits[index];
                  final doneToday =
                      h.completionByDate[DateFormat(AppConst.dateFormat).format(
                            DateTime.now(),
                          )] ??
                          false;
                  final streak =
                      ref.read(habitRepositoryProvider).computeCurrentStreak(h);

                  return TweenAnimationBuilder(
                    key: ValueKey(h.id),
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
                      habitId: h.id,
                      title: h.title,
                      emoji: h.emoji,
                      colorValue: h.colorValue,
                      currentStreak: streak,
                      doneToday: doneToday,
                      onToggle: () =>
                          ref.read(habitsProvider.notifier).toggleDone(
                                h.id,
                              ),
                      onEdit: () => _openHabitPopup(
                        context: context,
                        editHabit: h,
                      ),
                      onDelete: () => _deleteHabit(
                        context: context,
                        h: h,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<void> _deleteHabit({
    required BuildContext context,
    required Habit h,
  }) async {
    final appLocal = context.l10n;

    final isDeleted = await DialogUtils.showDeleteAlertDialog(
      context: context,
      title: appLocal.sayGoodbyeTo,
      message: appLocal.deletingWillErase,
      onDelete: () => context.pop(true),
      onCancel: () => context.pop(),
    );

    if (isDeleted == true) {
      ref.read(habitsProvider.notifier).deleteHabit(h.id);
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
