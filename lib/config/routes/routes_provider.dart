import 'package:ant_todo_list/config/routes/routes.dart';
import 'package:ant_todo_list/screens/create_task_screen.dart';
import 'package:ant_todo_list/screens/home_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routesProvider = Provider<GoRouter>((ref){
  return GoRouter(
    initialLocation: RouteLocation.home,
    navigatorKey: navigationKey,
    routes: appRoutes,
  );
},);


 final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return Homescreens();
        },
      ),
      GoRoute(
        path: '/createtask',
        builder: (BuildContext context, GoRouterState state) {
          return CreateTaskScreen();
        },
      ),
    ],
  );