import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:levelup/levelup.dart';

/// [LevelUpScreen]
/// A screen to showcase the user's Level Up statistics and achievements.
///
/// Features:
/// - Animated arrow background using [LevelUpBackground]
/// - Stats overview with [StatsCard] for:
///   - Total Days (total completed days across all habits)
///   - Committed Habits (total number of habits)
///   - Current Streak (highest ongoing streak among habits)
///   - Best Streak (highest historical streak among habits)
/// - Top 5 best habits displayed with [BestHabitCard], sorted by best streak
///
/// State Management:
/// - Uses Riverpod [Consumer] widgets to read:
///   - [habitsProvider] for habit data
///   - [habitRepositoryProvider] for streak computations
/// - Dynamic updates when habits or streaks change
///
/// UI Components:
/// - [StatsCard] to display key habit statistics
/// - [BestHabitCard] to show habit emoji, title, and best streak with emoji
/// - [ListView.builder] to render top habits
/// - [Stack] to overlay animated background with stats and cards
class LevelUpScreen extends StatelessWidget {
  const LevelUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;
    final appLocal = context.l10n;

    return Scaffold(
      body: Stack(
        children: [
          // Animated Level Up Background
          LevelUpBackground(),

          // Level Up
          SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats
                  Text(
                    appLocal.stats,
                    style: TextStyle(
                      color: colors.accent1,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 5.w,
                    children: [
                      // TOTAL DAYS
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, child) {
                            final habits = ref.watch(habitsProvider);
                            final days = <String>{};
                            for (final h in habits) {
                              h.completionByDate.forEach((day, done) {
                                if (done == true) days.add(day);
                              });
                            }
                            final totalDays = days.length;

                            return StatsCard(
                              title: appLocal.totalDays,
                              subtitle: appLocal.days,
                              value: totalDays.toString(),
                            );
                          },
                        ),
                      ),

                      // COMMITTED HABITS
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, child) {
                            final commitedHabits =
                                ref.watch(habitsProvider).length;

                            return StatsCard(
                              title: appLocal.committedHabits,
                              subtitle: appLocal.habitsTwo,
                              value: commitedHabits.toString(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 5.w,
                    children: [
                      // CURRENT STREAK
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, child) {
                            final habits = ref.watch(habitsProvider);
                            int currentStreak = 0;
                            for (final habit in habits) {
                              final streak = ref
                                  .read(habitRepositoryProvider)
                                  .computeCurrentStreak(habit);

                              if (streak >= currentStreak) {
                                currentStreak = streak;
                              }
                            }

                            return StatsCard(
                              title: appLocal.currentStreak,
                              subtitle: appLocal.days,
                              value: currentStreak.toString(),
                            );
                          },
                        ),
                      ),

                      // BEST STREAK
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, child) {
                            final habits = ref.watch(habitsProvider);
                            int bestStreak = 0;
                            for (final habit in habits) {
                              final streak = habit.bestStreak;

                              if (streak >= bestStreak) {
                                bestStreak = streak;
                              }
                            }

                            return StatsCard(
                              title: appLocal.bestStreak,
                              subtitle: appLocal.days,
                              value: bestStreak.toString(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),

                  // BEST HABITS
                  Card(
                    shadowColor: colors.primaryText,
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 6.h,
                        children: [
                          Text(
                            appLocal.bestHabits,
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final habits = ref.watch(habitsProvider);

                              List<Habit> bestHabits = List.from(habits);
                              bestHabits.sort(
                                (a, b) => b.bestStreak.compareTo(a.bestStreak),
                              );

                              bestHabits = bestHabits
                                  .take(5)
                                  .where(
                                    (habit) => habit.bestStreak > 0,
                                  )
                                  .toList();

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: bestHabits.length,
                                itemBuilder: (context, index) {
                                  final habit = bestHabits[index];

                                  return BestHabitCard(habit: habit);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
