import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:levelup/levelup.dart';

/// Repository layer for managing [Habit] persistence and streak logic.
///
/// Responsibilities:
/// - Provides CRUD operations for [Habit] objects stored in Hive.
/// - Encapsulates Hive box access behind a simple API.
/// - Generates standardized day keys using [AppConst.dateFormat].
/// - Computes current streaks for habits based on their completion history.
///
/// Notes:
/// - Each habit is stored in Hive using its [id] as the key.
/// - Streak calculation ignores "today" if incomplete, but breaks on past misses.
class HabitRepository {
  final Box<Habit> _box = Boxes.habits();

  List<Habit> loadAll() => _box.values.toList();

  Future<void> addHabit(Habit h) async => _box.put(h.id, h);

  Future<void> updateHabit(Habit h) async => _box.put(h.id, h);

  Future<void> deleteHabit(String id) async => _box.delete(id);

  String dayKey([DateTime? dt]) =>
      DateFormat(AppConst.dateFormat).format(dt ?? DateTime.now());

  int computeCurrentStreak(Habit h) {
    if (h.completionByDate.isEmpty) return 0;

    final dateFormat = DateFormat(AppConst.dateFormat);

    // Get all completed dates sorted ascending
    final completedDates = h.completionByDate.entries
        .where((e) => e.value)
        .map((e) => dateFormat.parse(e.key))
        .toList()
      ..sort();

    if (completedDates.isEmpty) return 0;

    int streak = 0;
    DateTime previousDate = completedDates.last; // Start from latest

    // If latest completed date is older than yesterday, streak starts fresh
    if (DateTime.now().difference(previousDate).inDays > 1) {
      streak = 0;
      previousDate = DateTime.now();
    } else {
      streak = 1;
    }

    // Count consecutive days backwards
    for (int i = completedDates.length - 2; i >= 0; i--) {
      final diff = previousDate.difference(completedDates[i]).inDays;
      if (diff == 1) {
        streak++;
        previousDate = completedDates[i];
      } else {
        break; // Gap → stop counting
      }
    }

    return streak;
  }
}
