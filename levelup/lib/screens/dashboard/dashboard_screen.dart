import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:levelup/levelup.dart';

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

class _DashboardScreenState extends State<DashboardScreen> {
  final _bottomNavProvider = StateProvider<int>((ref) => 0);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;

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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Habits',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard),
                label: 'Level Up',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
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
