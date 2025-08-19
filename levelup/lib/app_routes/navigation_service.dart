part of 'router.dart';

/// Provider for managing navigation state and redirection.
final navigationServiceProvider = ChangeNotifierProvider(
  (ref) => NavigationService(),
);

/// [Service] class for managing [navigation] and [redirection].
class NavigationService extends ChangeNotifier {
  String? _redirection;

  /// Navigates to the specified route.
  void go(String route) {
    _redirection = route; // Set the redirection route
    notifyListeners(); // Notify listeners about the change
  }

  /// Consumes the redirection route.
  String? _consumeRedirection() {
    if (_redirection != null) {
      final route = _redirection; // Store the redirection route
      _redirection = null; // Reset the redirection route
      return route; // Return the consumed redirection route
    }
    return null; // Return null if no redirection route is available
  }
}

/// Global key for accessing the root navigator state.
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Provider for configuring the GoRouter.
final _routerProvider = Provider((ref) {
  final redirectionService = ref.watch(navigationServiceProvider);
  final redirection = redirectionService._consumeRedirection();

  return GoRouter(
    initialLocation: redirection ??
        AppRoutes.splashScreen, // Set initial location from redirection or '/'
    navigatorKey: rootNavigatorKey, // Set the navigator key to rootNavigatorKey
    refreshListenable:
        redirectionService, // Refresh the router when redirection changes
    routes: routes, // Set the routes for GoRouter
  );
});
