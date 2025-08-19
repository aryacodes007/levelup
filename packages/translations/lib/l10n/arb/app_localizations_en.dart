// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get levelup => 'LevelUp';

  @override
  String get levelUpYourHabits => 'Level up your habits\nMake every day a win!';

  @override
  String get streak => 'Streak: ';

  @override
  String get addNewHabit => 'Add New Habit';

  @override
  String get habitName => 'Habit Name';

  @override
  String get hintHabitName => 'e.g., Drink Water';

  @override
  String get emptyHabitName => 'Please enter habit name';

  @override
  String get pickColor => 'Pick a Color';

  @override
  String get pickEmoji => 'Pick an Emoji';

  @override
  String get preview => 'Preview';

  @override
  String get saveHabit => 'Save Habit';

  @override
  String get noHabitsYet => 'No habits yet. Tap + to add one.';

  @override
  String get sayGoodbyeTo => 'Say Goodbye to This Habit?';

  @override
  String get deletingWillErase =>
      'Deleting will erase your streak history and progress?';
}
