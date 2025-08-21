import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:levelup/levelup.dart';

/// [DashboardScreen]
/// The main container screen of the app with bottom navigation.
///
/// Features:
/// - Hosts the primary app sections: **Habits**, **Level Up**, and **Settings**
/// - Provides a persistent bottom navigation bar
/// - Keeps state between tabs using [IndexedStack]
///
/// Navigation:
/// - Registered with GoRouter using [AppPageTransition]
///
/// State Management:
/// - Uses a local Riverpod [StateProvider<int>] for tracking the active tab
///
/// UI Components:
/// - [BottomNavigationBar] for navigation
/// - [HabitsScreen], [LevelUpScreen], and [SettingScreen] as tab contents
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static AppPageTransition builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      AppPageTransition(
        page: const DashboardScreen(),
        state: state,
        context: context,
      );

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

/// State class for [DashboardScreen].
///
/// Handles:
/// - Watching and updating the selected tab index
/// - Rendering the bottom navigation bar with icons & labels
/// - Switching between screens using [IndexedStack] to preserve state
class _DashboardScreenState extends State<DashboardScreen> {
  final _bottomNavProvider = StateProvider<int>(
    (ref) => 0,
  );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;
    final appLocal = context.l10n;

    return Scaffold(
      backgroundColor: colors.background,
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          return BottomNavigationBar(
            backgroundColor: colors.background,
            selectedItemColor: colors.accent1,
            unselectedItemColor: colors.primaryText,
            currentIndex: ref.watch(_bottomNavProvider),
            onTap: (index) =>
                ref.read(_bottomNavProvider.notifier).state = index,
            elevation: 0.01,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.local_drink_sharp),
                label: appLocal.habits,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard),
                label: appLocal.levelUp,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: appLocal.settings,
              ),
            ],
          );
        },
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final index = ref.watch(_bottomNavProvider);

          return IndexedStack(
            index: index,
            children: const [
              HabitsScreen(),
              LevelUpScreen(),
              SettingScreen(),
            ],
          );
        },
      ),
    );
  }
}
