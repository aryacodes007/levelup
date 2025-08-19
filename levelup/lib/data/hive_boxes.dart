import 'package:hive_flutter/hive_flutter.dart';
import 'package:levelup/levelup.dart';

/// Centralized access point for Hive boxes used in the app.
///
/// Responsibilities:
/// - Provides strongly-typed getters for commonly used boxes.
/// - Ensures consistent usage of Hive box names defined in [AppConst].
///
/// Notes:
/// - [habits] → Stores all [Habit] objects, keyed by their `id`.
/// - [settings] → Stores app-wide settings/preferences (dynamic box).
class Boxes {
  static Box<Habit> habits() => Hive.box<Habit>(AppConst.habits);
  static Box settings() => Hive.box(AppConst.settings);
}

