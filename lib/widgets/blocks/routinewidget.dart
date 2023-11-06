import 'package:flutter/material.dart';
import 'package:gymmanager/providers/db/resources/exercisecontainer.dart';
import 'package:gymmanager/widgets/pages/playroutine.dart';

class RoutineWidget extends StatefulWidget {
  final ExerciseContainer routine;
  final List<Object> exercises;
  const RoutineWidget(
      {super.key, required this.routine, required this.exercises});

  @override
  State<RoutineWidget> createState() => _RoutineWidgetState();
}

class _RoutineWidgetState extends State<RoutineWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.routine.name!,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    print(widget.exercises);
                  },
                  icon: const Icon(Icons.edit),
                  splashRadius: 25,
                  splashColor: const Color.fromARGB(150, 33, 149, 243),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlayRoutine(),
                        ));
                  },
                  icon: const Icon(Icons.play_arrow),
                  splashRadius: 25,
                  splashColor: const Color.fromARGB(150, 76, 175, 79),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  splashRadius: 25,
                  splashColor: const Color.fromARGB(150, 244, 67, 54),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
