import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ant_todo_list/config/routes/route_location.dart';
import 'package:ant_todo_list/utils/extensions.dart';

class SplashScreen extends ConsumerWidget {
  static SplashScreen builder(BuildContext context, GoRouterState state) =>
  const SplashScreen();
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool? initScreen = preferences.getBool('initScreen');
      if (initScreen == null || initScreen == 0) {
        Navigator.pushReplacementNamed(context, 'onboard');
      } else {
        Navigator.pushReplacementNamed(context, RouteLocation.home);
      }
    });

    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: Center(
        child: Image.asset(
          'assets/images/ant_splash_screen.png',
          width: context.deviceSize.height,
        ),
      ),
    );
  }
}
