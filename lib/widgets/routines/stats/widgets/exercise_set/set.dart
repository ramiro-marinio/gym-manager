import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercise_recording/setrecord.dart';
import 'package:gymmanager/widgets/routines/stats/widgets/exercise_set/repped_exercise.dart';
import 'package:gymmanager/widgets/routines/stats/widgets/exercise_set/timed_exercise.dart';

class ExerciseSet extends StatefulWidget {
  final Exercise exercise;
  final int setNumber;
  final SetRecord record;
  const ExerciseSet({
    super.key,
    required this.exercise,
    required this.setNumber,
    required this.record,
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
        setNumber: widget.setNumber,
        exercise: widget.exercise,
        record: widget.record,
      );
    } else {
      return TimeExercise(
        setNumber: widget.setNumber,
        exercise: widget.exercise,
        record: widget.record,
      );
    }
  }
}
