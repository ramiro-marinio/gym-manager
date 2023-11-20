import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercise_recording/setrecord.dart';
import 'package:gymmanager/widgets/routine_usage/stats/widgets/exercise_set/repped_exercise.dart';
import 'package:gymmanager/widgets/routine_usage/stats/widgets/exercise_set/timed_exercise.dart';

class ExerciseSet extends StatefulWidget {
  final Exercise exercise;
  final String label;
  final SetRecord record;
  final bool mini;
  const ExerciseSet({
    super.key,
    required this.exercise,
    required this.label,
    required this.record,
    required this.mini,
  });
  @override
  State<ExerciseSet> createState() => _ExerciseSetState();
}

class _ExerciseSetState extends State<ExerciseSet> {
  int reps = 1;
  @override
  Widget build(BuildContext context) {
    if (widget.exercise.exerciseType.repunit) {
      return RepsExercise(
        label: widget.label,
        exercise: widget.exercise,
        record: widget.record,
        mini: widget.mini,
      );
    } else {
      return TimeExercise(
        label: widget.label,
        exercise: widget.exercise,
        record: widget.record,
        mini: widget.mini,
      );
    }
  }
}
