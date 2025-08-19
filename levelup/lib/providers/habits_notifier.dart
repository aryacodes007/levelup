import 'package:levelup/levelup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

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

  /// Add new habit with optional emoji
  Future<void> addUpdateHabit({
    String? id,
    required String title,
    required int colorValue,
    required String emoji,
  }) async {
    if (id != null) {
      state = state.map((h) {
        if (h.id == id) {
          final updated = Habit(
            id: h.id,
            title: title,
            colorValue: colorValue,
            emoji: emoji,
            bestStreak: h.bestStreak,
            completionByDate: Map.from(h.completionByDate),
          );
          Boxes.habits().put(updated.id, updated);
          return updated;
        }
        return h;
      }).toList();
    } else {
      final id = const Uuid().v4();
      final h = Habit(
        id: id,
        title: title,
        colorValue: colorValue,
        emoji: emoji,
      );
      await repo.addHabit(h);
      state = [...state, h];
    }
  }

  /// Update existing habit
  Future<void> updateHabit(
    String id, {
    String? newTitle,
    int? newColorValue,
    String? newEmoji,
  }) async {}

  /// Toggle done status for today
  Future<void> toggleDone(String habitId) async {
    final today = repo.dayKey();
    state = [
      for (final h in state)
        if (h.id == habitId) _updateHabitCompletion(h, today) else h,
    ];
  }

  Habit _updateHabitCompletion(Habit h, String dayKey) {
    final map = Map<String, bool>.from(h.completionByDate);
    final newVal = !(map[dayKey] ?? false);
    map[dayKey] = newVal;
    var newBest = h.bestStreak;
    if (newVal) {
      final streak = repo.computeCurrentStreak(h..completionByDate = map);
      newBest = max(newBest, streak);
    }
    final updated = Habit(
      id: h.id,
      title: h.title,
      colorValue: h.colorValue,
      emoji: h.emoji,
      bestStreak: newBest,
      completionByDate: map,
    );
    Boxes.habits().put(updated.id, updated);
    return updated;
  }

  /// Delete habit
  Future<void> deleteHabit(String id) async {
    await Boxes.habits().delete(id);
    state = state.where((e) => e.id != id).toList();
  }
}
