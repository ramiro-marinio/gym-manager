import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromARGB(255, 128, 187, 255),
        child: ListView(
          children: [
            ListTile(
              title: const Text("Home Screen"),
              leading: const Icon(
                Icons.home,
                color: Colors.black,
              ),
              onTap: () {
                context.go('/');
              },
            ),
            ListTile(
              title: const Text("My Routines"),
              leading: const Icon(
                Icons.fitness_center,
                color: Colors.black,
              ),
              onTap: () {
                context.go('/routines');
              },
            ),
            ListTile(
              title: const Text("Exercises Manager"),
              leading: const Icon(
                Icons.list,
                color: Colors.black,
              ),
              onTap: () {
                context.go('/exercises');
              },
            ),
            ListTile(
              title: const Text("Settings"),
              leading: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onTap: () {
                context.go('/user_settings');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.help,
                color: Colors.black,
              ),
              title: const Text("Help"),
              onTap: () {
                context.go('/help');
              },
            ),
            Visibility(
              visible: kDebugMode,
              child: ListTile(
                title: const Text("Sql (DEVELOPER ONLY)"),
                leading: const Icon(
                  Icons.engineering,
                  color: Colors.black,
                ),
                onTap: () {
                  context.go('/sql_settings');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
