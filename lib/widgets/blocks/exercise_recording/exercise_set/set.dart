import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/widgets/blocks/exercise_recording/exercise_set/repped_exercise.dart';
import 'package:gymmanager/widgets/blocks/exercise_recording/exercise_set/timed_exercise.dart';

class ExerciseSet extends StatefulWidget {
  final Exercise exercise;
  final int setNumber;
  const ExerciseSet(
      {super.key, required this.exercise, required this.setNumber});
  @override
  State<ExerciseSet> createState() => _ExerciseSetState();
}

class _ExerciseSetState extends State<ExerciseSet> {
  int reps = 1;
  @override
  Widget build(BuildContext context) {
    if (widget.exercise.exerciseType.repunit) {
      return RepsExercise(
        setNumber: widget.setNumber,
        exercise: widget.exercise,
      );
    } else {
      return TimeExercise(
        setNumber: widget.setNumber,
        exercise: widget.exercise,
      );
    }
  }
}
