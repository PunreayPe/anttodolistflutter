import 'package:ant_todo_list/config/routes/routes.dart';
import 'package:ant_todo_list/config/theme/theme.dart';
import 'package:ant_todo_list/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AntTodoList extends ConsumerWidget {
  const AntTodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'Ant Todolist',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashScreen(),
        RouteLocation.home: (context) => const Homescreens(),
        'onboard': (context) => Onboardingscreen(),
      },
    );
  }
}
