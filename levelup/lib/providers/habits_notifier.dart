import 'dart:collection';

import 'package:levelup/levelup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';
import 'package:intl/intl.dart';

/// Riverpod provider that exposes a singleton [HabitRepository].
///
/// Responsibilities:
/// - Central access point for all habit persistence and streak logic.
/// - Keeps repository lifecycle managed by Riverpod.
final habitRepositoryProvider = Provider<HabitRepository>(
  (ref) => HabitRepository(),
);

/// Riverpod provider that exposes the [HabitsNotifier] state (list of [Habit]s).
///
/// Responsibilities:
/// - Loads all habits on initialization.
/// - Reactively updates when habits are added, updated, deleted, or toggled.
/// - Provides the source of truth for habit state across the app.
final habitsProvider =
    StateNotifierProvider<HabitsNotifier, List<Habit>>((ref) {
  final repo = ref.watch(habitRepositoryProvider);
  return HabitsNotifier(repo)..load();
});

/// StateNotifier that manages the list of [Habit]s in the app.
///
/// Responsibilities:
/// - Provides CRUD operations on habits (add, update, delete).
/// - Syncs state changes with Hive via [HabitRepository] / [Boxes].
/// - Handles business logic like toggling completion and updating streaks.
/// - Keeps Riverpod state in sync with the local Hive store.
///
/// Notes:
/// - Exposed via [habitsProvider] for UI consumption.
/// - Automatically loads all habits on initialization.
/// - Uses [repo.computeCurrentStreak] to update streaks and best streaks.
class HabitsNotifier extends StateNotifier<List<Habit>> {
  final HabitRepository repo;
  HabitsNotifier(this.repo) : super(const []);

  void load() {
    state = repo.loadAll();
  }

  /// Add new habit or update habit
  Future<void> addUpdateHabit({
    String? id,
    required String title,
    required int colorValue,
    required String emoji,
  }) async {
    if (id != null) {
      state = state.map((habit) {
        if (habit.id == id) {
          final updated = Habit(
            id: habit.id,
            title: title,
            colorValue: colorValue,
            emoji: emoji,
            bestStreak: habit.bestStreak,
            completionByDate: Map.from(habit.completionByDate),
          );
          Boxes.habits().put(updated.id, updated);
          return updated;
        }
        return habit;
      }).toList();
    } else {
      final date = DateFormat(AppConst.dateFormat).format(
        DateTime.now(),
      );
      final id = const Uuid().v4();
      final h = Habit(
        id: id,
        title: title,
        colorValue: colorValue,
        emoji: emoji,
        completionByDate: {date: false},
        bestStreak: 0,
      );
      await repo.addHabit(h);
      state = [...state, h];
    }
  }

  /// Toggle done status for today
  Future<void> toggleDone(String habitId) async {
    final today = repo.dayKey();
    state = [
      for (final h in state)
        if (h.id == habitId) _updateHabitCompletion(h, today) else h,
    ];
  }

  Habit _updateHabitCompletion(Habit habit, String dayKey) {
    final dateFormat = DateFormat(AppConst.dateFormat);
    final map = Map<String, bool>.from(habit.completionByDate);

    // Toggle today's completion
    map[dayKey] = !(map[dayKey] ?? false);

    // Fill missing days between earliest and latest date
    if (map.isNotEmpty) {
      final dates = map.keys.map(dateFormat.parse).toList()..sort();
      final start = dates.first;
      final end = dates.last;

      for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
        map.putIfAbsent(dateFormat.format(d), () => false);
      }
    }

    // Sort map by date and keep order
    final sortedMap = SplayTreeMap<String, bool>((a, b) {
      final da = dateFormat.parse(a);
      final db = dateFormat.parse(b);
      return da.compareTo(db);
    });
    sortedMap.addAll(map);

    // Compute current streak
    final tempHabit = habit..completionByDate = sortedMap;
    final currentStreak =
        sortedMap[dayKey]! ? repo.computeCurrentStreak(tempHabit) : 0;

    // Update best streak
    final newBest = max(habit.bestStreak, currentStreak);

    // Create updated habit
    final updated = Habit(
      id: habit.id,
      title: habit.title,
      colorValue: habit.colorValue,
      emoji: habit.emoji,
      bestStreak: newBest,
      completionByDate: sortedMap,
    );

    // Save updated habit
    Boxes.habits().put(updated.id, updated);

    return updated;
  }

  /// Delete habit
  Future<void> deleteHabit(String id) async {
    await Boxes.habits().delete(id);
    state = state.where((e) => e.id != id).toList();
  }

  /// Reset All Habits
  Future<void> respawnHabits() async {
    await Boxes.habits().clear();
    state = [];
  }
}
