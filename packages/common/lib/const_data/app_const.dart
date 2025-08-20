/// Application Constants
///
/// Provides centralized string keys and default values used
/// across the application for Hive storage and app settings.
///
/// Contains:
/// - Box names: [habits], [settings]
/// - Keys for user preferences: [streakEmoji], [themeModeName]
/// - Default values for initialization
/// - Common formats (e.g., [dateFormat])
///
/// Usage:
/// - Access Hive box names via [AppConst.habits], [AppConst.settings]
/// - Retrieve defaults such as [AppConst.defaultEmoji]
/// - Ensure consistency when saving/retrieving values in storage
class AppConst {
  AppConst._();

  static const String habits = 'habits';
  static const String settings = 'settings';

  static const String defaultEmoji = '🥛';
  static const String defaultStreakEmoji = '🔥';

  static const String dateFormat = 'dd-MM-yyyy';
  static const String streakEmoji = 'streakEmoji';
  static const String themeModeName = 'themeModeName';
}
