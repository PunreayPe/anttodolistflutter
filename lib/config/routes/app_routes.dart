import 'package:ant_todo_list/config/routes/route_location.dart';
import 'package:ant_todo_list/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigationKey = GlobalKey<NavigatorState>();

final appRoutes = [
  GoRoute(
    path: RouteLocation.onboardingscreen,
    parentNavigatorKey: navigationKey,
    builder: Onboardingscreen.builder,
  ),
  GoRoute(
    path: RouteLocation.splashscreen,
    parentNavigatorKey: navigationKey,
    builder: SplashScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: Homescreens.builder,
  ),
  GoRoute(
    path: RouteLocation.createtask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  ),
];