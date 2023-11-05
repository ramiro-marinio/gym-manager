import 'package:flutter/material.dart';
import 'package:gymmanager/providers/db/resources/exercisecontainer.dart';

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
    return Card(
      child: Text(widget.routine.name!),
    );
  }
}
