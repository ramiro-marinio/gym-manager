import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/widgets/routines/view_routine/widgets/exerciseviewer.dart';
import 'package:gymmanager/widgets/routines/view_routine/supersetviewer.dart';

class ShowRoutine extends StatefulWidget {
  final String title;
  final String description;
  final List<Object> routine;
  const ShowRoutine(
      {super.key,
      required this.routine,
      required this.title,
      required this.description});

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
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
          ),
          Visibility(
            visible: widget.description.isNotEmpty,
            maintainSize: false,
            maintainState: true,
            child: Text(
              widget.description,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          ...List.generate(
            widget.routine.length,
            (index) {
              if (widget.routine[index].runtimeType == Exercise) {
                return ExerciseViewer(
                  exercise: widget.routine[index] as Exercise,
                  mini: false,
                );
              } else {
                return SupersetViewer(
                    superset: widget.routine[index] as ExerciseContainer);
              }
            },
          ),
        ]),
      ),
    );
  }
}
