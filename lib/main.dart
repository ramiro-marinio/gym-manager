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
// class App extends StatefulWidget {
//   const App({super.key});

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   int currentScreen = 0;

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> screens = [
//       HomeScreen(),
//       Routines(),
//       ExerciseManager(),
//     ];

//     return MaterialApp(
//       theme: ThemeData.dark(),
//       title: "Gym Manager",
//       home: screens[currentScreen],
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Widget> screens = [
//     const HomeScreen(),
//     const Routines(),
//     const ExerciseManager(),
//   ];
//   int currentScreen = 0;
//   void switchScreen(int index) {
//     setState(() {
//       currentScreen = index;
//       Navigator.pop(context);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Gym Manager"),
//         ),
//         drawer: NavDrawer(),
//         body: screens[currentScreen]);
//   }
// }