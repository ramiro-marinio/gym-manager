import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/widgets/blocks/view_routine/exerciseviewer.dart';
import 'package:gymmanager/widgets/blocks/view_routine/supersetviewer.dart';

class ShowRoutine extends StatefulWidget {
  final List<Object> routine;
  const ShowRoutine({super.key, required this.routine});

  @override
  State<ShowRoutine> createState() => _ShowRoutineState();
}

class _ShowRoutineState extends State<ShowRoutine> {
  List<Widget> table = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Routine')),
      body: SingleChildScrollView(
          child: Column(
              children: List.generate(widget.routine.length, (index) {
        if (widget.routine[index].runtimeType == Exercise) {
          return ExerciseViewer(
            exercise: widget.routine[index] as Exercise,
            mini: false,
          );
        } else {
          return SupersetViewer(
              superset: widget.routine[index] as ExerciseContainer);
        }
      }))),
    );
  }
}
