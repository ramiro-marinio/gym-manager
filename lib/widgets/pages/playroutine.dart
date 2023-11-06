import 'package:flutter/material.dart';
import 'package:gymmanager/providers/routineplayprovider.dart';
import 'package:provider/provider.dart';

class PlayRoutine extends StatefulWidget {
  const PlayRoutine({super.key});

  @override
  State<PlayRoutine> createState() => _PlayRoutineState();
}

class _PlayRoutineState extends State<PlayRoutine> {
  @override
  Widget build(BuildContext context) {
    RoutinePlayProvider provider = Provider.of<RoutinePlayProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Play Routine")),
      body: const Placeholder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (provider.subscription == null) {
            provider.initializeTimer(0);
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
