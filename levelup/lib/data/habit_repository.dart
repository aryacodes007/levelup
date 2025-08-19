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
    final today = DateFormat(AppConst.dateFormat).format(DateTime.now());

    final sortedKeys = h.completionByDate.keys.toList()
      ..sort((a, b) {
        final pa = DateFormat(AppConst.dateFormat).parse(a);
        final pb = DateFormat(AppConst.dateFormat).parse(b);
        return pa.compareTo(pb);
      });

    int streak = 0;

    for (int i = sortedKeys.length - 1; i >= 0; i--) {
      final date = sortedKeys[i];
      final value = h.completionByDate[date] ?? false;

      if (date == today) {
        if (value) {
          streak++;
        }
        continue;
      }

      if (value) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }
}

