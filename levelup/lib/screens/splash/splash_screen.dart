import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:levelup/levelup.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static AppPageTransition builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      AppPageTransition(
        page: const SplashScreen(),
        state: state,
        context: context,
      );

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  // Drinking/Water color palette
  final waterColors = const [
    Color(0xFFB2EBF2), // light aqua
    Color(0xFF80DEEA), // medium aqua
    Color(0xFF4DD0E1), // deep aqua
    Color(0xFF26C6DA), // bright water blue
    Color(0xFF00BCD4), // cyan
    Color(0xFF0097A7), // dark cyan
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getSettingsData();

      Future.delayed(const Duration(seconds: 5, milliseconds: 500))
          .then((value) {
        context.go(AppRoutes.dashboardScreen);
      });
    });
  }

  void _getSettingsData() {
    String? streakEmoji = Hive.box(AppConst.settings).get(
      AppConst.streakEmoji,
    );
    if (streakEmoji == null) {
      Hive.box(AppConst.settings).put(
        AppConst.streakEmoji,
        AppConst.defaultStreakEmoji,
      );
      streakEmoji = AppConst.defaultStreakEmoji;
    }

    String? themeModeName =
        Hive.box(AppConst.settings).get(AppConst.themeModeName) as String?;

    themeModeName = themeModeName ?? ThemeMode.system.name;

    final themeMode = ThemeMode.values.byName(themeModeName);

    ref.read(themeModeProvider.notifier).state = themeMode;
    ref.read(streakEmojiProvider.notifier).state = streakEmoji;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;
    final appLocal = context.l10n;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textAlign = TextAlign.center;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // Animated bubbles background
          BubbleBackground(
            isDark: isDark,
            bubbleColors: waterColors,
            bubbleCount: 40, // Increased bubble count
          ),

          // Title and Sub Title
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                // Title
                Text(
                  appLocal.levelup,
                  textAlign: textAlign,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),

                // Subtitle
                TypewriterText(
                  text: appLocal.levelUpYourHabits,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
