import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
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
            )
          ],
        ),
      ),
    );
  }
}
