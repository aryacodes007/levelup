import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:levelup/levelup.dart';

class SplashScreen extends StatefulWidget {
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
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      Future.delayed(const Duration(seconds: 3)).then((value) {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = context.l10n;
    final textAlign = TextAlign.center;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 16.h,
            ),
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
            Text(
              appLocal.levelUpYourHabits,
              textAlign: textAlign,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }


}

