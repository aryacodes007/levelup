import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:levelup/levelup.dart';

/// 🚀 Application Entry Point
///
/// Responsibilities:
/// - Initializes Hive local database
///   - Registers [HabitAdapter] for habit persistence
///   - Opens `habits` and `settings` boxes
/// - Configures system UI overlay (transparent status bar)
/// - Bootstraps the Flutter app with Riverpod [ProviderScope]
///
/// Flow:
/// 1. Initialize [Hive]
/// 2. Register [adapters] & open [boxes]
/// 3. Configure system [UI]
/// 4. Run [MyApp] as the root widget
Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  await Hive.openBox<Habit>(AppConst.habits);
  await Hive.openBox(AppConst.settings);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  // Initialize the app
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}
