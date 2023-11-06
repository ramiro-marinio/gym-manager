import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/routineplayprovider.dart';
import 'package:provider/provider.dart';

class PlayRoutine extends StatefulWidget {
  final ExerciseContainer routine;
  final List<Object> exercises;
  const PlayRoutine(
      {super.key, required this.routine, required this.exercises});
  @override
  State<PlayRoutine> createState() => _PlayRoutineState();
}

class _PlayRoutineState extends State<PlayRoutine> {
  final PageController pc = PageController();
  @override
  Widget build(BuildContext context) {
    RoutinePlayProvider provider = Provider.of<RoutinePlayProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Play Routine")),
      body: Column(
        children: [
          PageView(
            controller: pc,
            physics: const NeverScrollableScrollPhysics(),
            children: const [Text("A"), Text("B"), Text("C")],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (provider.subscription == null) {
            provider.initializeTimer(0, widget.routine);
          } else {
            provider.toggleTimer();
          }
        },
        child: provider.timerActive
            ? const Icon(Icons.pause)
            : const Icon(Icons.play_arrow),
      ),
    );
  }
}
