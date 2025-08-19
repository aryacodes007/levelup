import 'package:hive/hive.dart';
import 'package:levelup/levelup.dart';

part 'habit_model.g.dart'; // Informational; adapter is defined manually below.

/// Hive Data Model: Habit
///
/// Represents a single habit that a user is tracking.
/// Stored locally using Hive for persistence.
///
/// Fields:
/// - [id]: Unique identifier for the habit (UUID or custom).
/// - [title]: The name of the habit (e.g., "Drink Water").
/// - [colorValue]: The ARGB int value for the habit’s theme color.
/// - [emoji]: Emoji symbol used to visually represent the habit.
/// - [bestStreak]: Highest streak of consecutive completions.
/// - [completionByDate]: A map of completion status keyed by date (format: dd-MM-yyyy).
///
/// Notes:
/// - Uses a manual adapter instead of code generation (`build_runner`).
/// - Default emoji is provided via [AppConst.defaultEmoji].
/// - Hive typeId = 1 must remain unique across all Hive objects.
@HiveType(typeId: 1)
class Habit extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int colorValue;

  @HiveField(3)
  String emoji; // <-- replaced iconName

  @HiveField(4)
  int bestStreak;

  @HiveField(5)
  Map<String, bool> completionByDate; // dd-MM-yyyy -> done?

  Habit({
    required this.id,
    required this.title,
    required this.colorValue,
    this.emoji = AppConst.defaultEmoji, // default emoji
    this.bestStreak = 0,
    Map<String, bool>? completionByDate,
  }) : completionByDate = completionByDate ?? {};
}

/// Hive TypeAdapter for [Habit].
///
/// Responsible for serializing/deserializing [Habit] objects
/// to and from Hive’s binary storage format.
///
/// Implementation details:
/// - [read]: Reconstructs a [Habit] from stored binary data.
/// - [write]: Converts a [Habit] into binary format for Hive.
/// - Uses a fixed field order; changing indexes will break compatibility.
/// - Total field count written: 6
class HabitAdapters extends TypeAdapter<Habit> {
  @override
  final int typeId = 1;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return Habit(
      id: fields[0] as String,
      title: fields[1] as String,
      colorValue: fields[2] as int,
      emoji: fields[3] as String,
      bestStreak: fields[4] as int,
      completionByDate: (fields[5] as Map).cast<String, bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(6) // total number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.colorValue)
      ..writeByte(3)
      ..write(obj.emoji)
      ..writeByte(4)
      ..write(obj.bestStreak)
      ..writeByte(5)
      ..write(obj.completionByDate);
  }
}

