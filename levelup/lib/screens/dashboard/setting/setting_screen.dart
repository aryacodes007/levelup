import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final themeMode = ref.watch(themeModeProvider);
                final isDark = themeMode == ThemeMode.dark;

                return SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Toggle light/dark theme'),
                  value: isDark,
                  onChanged: (_) => ref.read(themeModeProvider.notifier).state =
                      isDark ? ThemeMode.light : ThemeMode.dark,
                );
              },
            ),
            ListTile(
              title: const Text('Reset all habits'),
              subtitle: const Text('This will remove all your habit data'),
              trailing: const Icon(Icons.delete_forever),
              onTap: () async {
                final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Reset all habits?'),
                        content: const Text('This action cannot be undone.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text(
                              'Reset',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ) ??
                    false;
                if (confirmed) {
                  // await Boxes.habits().clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All habits reset.'),
                    ),
                  );
                }
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final emoji = ref.watch(streakEmojiProvider);

                return ListTile(
                  title: const Text('Change your streak emoji'),
                  subtitle: const Text(
                      'Your streak, your style — choose the emoji you like.'),
                  trailing: Text(
                    emoji,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async => ServiceUtils.showEmojiKeyboard(
                    context: context,
                    onEmojiSelected: (emoji) {
                      Hive.box('settings').put('streakEmoji', emoji);
                      ref.read(streakEmojiProvider.notifier).state = emoji;
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

final themeModeProvider = StateProvider<ThemeMode>(
  (ref) => ThemeMode.light,
);

final streakEmojiProvider = StateProvider<String>(
  (ref) => '',
);
