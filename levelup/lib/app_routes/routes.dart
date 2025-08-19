import 'package:levelup/levelup.dart';

/// Define [routes] with corresponding [page] builders
List<RouteBase> routes = [
  // Splash Screen
  GoRoute(
    path: AppRoutes.splashScreen,
    pageBuilder: SplashScreen.builder,
  ),

  // Dashboard Screen
  GoRoute(
    path: AppRoutes.dashboardScreen,
    pageBuilder: DashboardScreen.builder,
  ),
];
