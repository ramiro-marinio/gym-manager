import 'package:flutter/material.dart';
import 'package:gymmanager/functions/displaytime.dart';
import 'package:gymmanager/providers/routineplayprovider.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  final VoidCallback previousPage;
  final VoidCallback nextPage;

  const NavBar({
    super.key,
    required this.previousPage,
    required this.nextPage,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    @override
    RoutinePlayProvider provider = Provider.of<RoutinePlayProvider>(context);
    return Material(
      color: const Color.fromARGB(255, 82, 89, 183),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              displayTime(Duration(seconds: provider.time)),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            IconButton(
              onPressed: () {
                widget.previousPage();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              splashRadius: 25,
            ),
            IconButton(
              onPressed: () {
                widget.nextPage();
              },
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              splashRadius: 25,
            ),
          ],
        ),
      ),
    );
  }
}
