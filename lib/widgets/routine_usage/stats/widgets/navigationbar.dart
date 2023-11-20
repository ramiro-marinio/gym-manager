import 'package:flutter/material.dart';
import 'package:gymmanager/functions/displaytime.dart';
import 'package:gymmanager/providers/routineplayprovider.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  final VoidCallback previousPage;
  final VoidCallback nextPage;
  final VoidCallback timerButton;
  const NavBar(
      {super.key,
      required this.previousPage,
      required this.nextPage,
      required this.timerButton});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    @override
    RoutinePlayProvider routinePlayProvider =
        Provider.of<RoutinePlayProvider>(context);
    return Expanded(
      flex: 1,
      child: Material(
        color: const Color.fromARGB(255, 82, 89, 183),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                displayTime(
                    duration: Duration(seconds: routinePlayProvider.time),
                    displayHours: true),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {
                  widget.timerButton();
                },
                icon: routinePlayProvider.timerActive
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
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
      ),
    );
  }
}
