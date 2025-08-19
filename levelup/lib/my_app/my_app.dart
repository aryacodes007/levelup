import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:levelup/levelup.dart';

/// Root widget of the application.
///
/// Responsibilities:
/// - Initializes screen utilities for responsive design via [ScreenUtilInit].
/// - Configures app-wide routing using [AppRouter] and [GoRouter].
/// - Provides theming support (light/dark) based on [themeModeProvider].
/// - Sets up localization delegates and supported locales for i18n.
/// - Wraps the app in Riverpod's [Consumer] to reactively update theme mode.
///
/// Notes:
/// - `designSize` (375x812) is based on iPhone X dimensions for scaling.
/// - Uses `MaterialApp.router` to integrate declarative navigation.
/// - Hides the debug banner in release and debug modes.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return AppRouter(
          builder: (context, goRouter) {
            return Consumer(
              builder: (context, ref, child) {
                final themeMode = ref.watch(themeModeProvider);

                return MaterialApp.router(
                  routerConfig: goRouter,
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: themeMode,
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                );
              },
            );
          },
        );
      },
    );
  }
}
