import 'package:levelup/levelup.dart';

/// Define [routes] with corresponding [page] builders
List<RouteBase> routes = [
  // Splash Screen: Splash Screen
  GoRoute(
    path: AppRoutes.splash,
    pageBuilder: SplashScreen.builder,
  ),
];
