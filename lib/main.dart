import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymmanager/db/dbprovider.dart';
import 'package:gymmanager/widgets/pages/exercisemanager.dart';
import 'package:gymmanager/widgets/pages/homescreen.dart';
import 'package:gymmanager/widgets/pages/routines.dart';
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
    )
  ]);
  runApp(
    ChangeNotifierProvider(
      create: (_) => DbProvider(),
      child: MaterialApp.router(
        title: "Gym Manager",
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.indigo,
            ),
            scaffoldBackgroundColor: Colors.blue[100]),
        darkTheme: ThemeData.dark(),
        routerConfig: gorouter,
      ),
    ),
  );
}
