import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:levelup/levelup.dart';

/// [SettingScreen]
/// A screen for managing user preferences and app configurations.
///
/// Features:
/// - Toggle between **Light / Dark / System** theme modes
/// - Respawn (delete & reset) all habits with confirmation
/// - Change streak emoji using a custom emoji picker
///
/// State Management:
/// - Uses Riverpod [StateProvider] for theme mode and streak emoji
/// - Persists values with Hive for app-wide usage
///
/// UI Components:
/// - [SettingCard] to group each setting with title & subtitle
/// - [ThemeModeToggle] for theme selection
/// - [SettingIconButton] for actions like delete & emoji change
/// - Confirmation dialogs & success feedback for destructive actions
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;
    final appLocal = context.l10n;

    return Scaffold(
      body: Stack(
        children: [
          // Animated Settings background
          SettingsBackground(
            key: ValueKey(colors.accent1),
            colorPalette: [
              colors.primaryText,
              colors.accent1,
              colors.accent2,
              colors.button,
              colors.error,
            ],
          ),

          // Settings
          SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 8.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Choose Your Realm
                  SettingCard(
                    title: appLocal.themeModeTitle,
                    subTitle: appLocal.themeModeSubtitle,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final themeMode = ref.watch(themeModeProvider);

                        return ThemeModeToggle(
                          themeMode: themeMode,
                          onChanged: (updatedThemeMode) => {
                            Hive.box(AppConst.settings).put(
                              AppConst.themeModeName,
                              updatedThemeMode.name,
                            ),
                            ref.read(themeModeProvider.notifier).state =
                                updatedThemeMode,
                          },
                        );
                      },
                    ),
                  ),

                  // Respawn habits
                  SettingCard(
                    title: appLocal.respawnHabitsTitle,
                    subTitle: appLocal.respawnHabitsSubtitle,
                    child: Consumer(
                      builder: (context, ref, child) {
                        return SettingIconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            color: colors.error,
                            size: 22.w,
                          ),
                          splashColor: colors.error,
                          onPressed: () => _onRespawnHabits(
                            context: context,
                            ref: ref,
                          ),
                        );
                      },
                    ),
                  ),

                  // Change Streak Emoji
                  SettingCard(
                    title: appLocal.changeStreakEmoji,
                    subTitle: appLocal.yourStreakYourStyle,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final emoji = ref.watch(streakEmojiProvider);

                        return SettingIconButton(
                          onPressed: () => ServiceUtils.showEmojiKeyboard(
                            context: context,
                            onEmojiSelected: (emoji) => {
                              Hive.box(AppConst.settings).put(
                                AppConst.streakEmoji,
                                emoji,
                              ),
                              ref.read(streakEmojiProvider.notifier).state = emoji,
                            },
                          ),
                          splashColor: colors.accent1,
                          icon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: Text(
                              emoji,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onRespawnHabits({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final appLocal = context.l10n;

    final confirmed = await DialogUtils.showDeleteAlertDialog(
          context: context,
          title: '${appLocal.respawnHabitsTitle}?',
          message: appLocal.respawnHabitsMessage,
          deleteText: appLocal.respawn,
          cancelText: appLocal.cancel,
          onDelete: () => context.pop(true),
          onCancel: context.pop,
        ) ??
        false;
    if (confirmed) {
      ref.read(habitsProvider.notifier).respawnHabits();
      DialogUtils.showDeleteSuccessDialog(
        context: context,
        asset: 'assets/lottie/success.json',
        message: context.l10n.respawnHabitsSuccess,
        onLoaded: context.pop,
      );
    }
  }
}
