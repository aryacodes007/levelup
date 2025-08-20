import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:levelup/levelup.dart';

/// Riverpod provider for persisting and exposing the current [ThemeMode].
///
/// Responsibilities:
/// - Reads the saved theme mode from Hive settings box (key: [AppConst.themeModeName]).
/// - Falls back to [ThemeMode.system] if no preference is stored.
/// - Exposes the current theme mode to the app for light/dark mode switching.
final themeModeProvider = StateProvider<ThemeMode>(
  (ref) {
    ThemeMode themeMode = ThemeMode.system;

    final themeModeName = Hive.box(AppConst.settings).get(
      AppConst.themeModeName,
    ) as String?;

    if (themeModeName != null) {
      themeMode = ThemeMode.values.byName(themeModeName);
    }

    return themeMode;
  },
);

/// Riverpod provider for the emoji used to represent [streaks].
///
/// Responsibilities:
/// - Exposes the current streak emoji for use in UI (e.g., habit streak display).
/// - Defaults to [AppConst.defaultStreakEmoji].
final streakEmojiProvider = StateProvider<String>(
  (ref) {
    return AppConst.defaultStreakEmoji;
  },
);
