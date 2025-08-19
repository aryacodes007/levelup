import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:levelup/levelup.dart';

/// The main [function] is the [entry] [point] of the [application]
Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  await Hive.openBox<Habit>('habits');
  await Hive.openBox('settings');

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
