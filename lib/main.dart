import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymmanager/providers/dbprovider.dart';
import 'package:gymmanager/providers/routinecreationprovider.dart';
import 'package:gymmanager/providers/routineplayprovider.dart';
import 'package:gymmanager/widgets/pages/exercisemanager.dart';
import 'package:gymmanager/widgets/pages/homescreen.dart';
import 'package:gymmanager/widgets/pages/routines.dart';
import 'package:gymmanager/widgets/pages/settings.dart';
import 'package:gymmanager/widgets/pages/sql_page.dart';
import 'package:provider/provider.dart';

void main() {
  GoRouter gorouter = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/routines',
      builder: (context, state) => const Routines(),
    ),
    GoRoute(
      path: '/exercises',
      builder: (context, state) => const ExerciseManager(),
    ),
    GoRoute(
      path: '/sql_settings',
      builder: (context, state) => const SqlPage(),
    ),
    GoRoute(
      path: "/user_settings",
      builder: (context, state) => SettingsPage(),
    ),
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<DbProvider>(create: (_) => DbProvider()),
      ChangeNotifierProvider<CreationProvider>(
          create: (_) => CreationProvider()),
      ChangeNotifierProvider(create: (_) => RoutinePlayProvider()),
    ],
    child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Gym Manager",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
        ),
        scaffoldBackgroundColor: Colors.blue[100],
        sliderTheme: const SliderThemeData(
            showValueIndicator: ShowValueIndicator.always),
      ),
      routerConfig: gorouter,
    ),
  ));
}
