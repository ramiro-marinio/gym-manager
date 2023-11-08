import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/widgets/routines/stats/exercise_set/set.dart';

class Recorder extends StatelessWidget {
  final Object exercise;
  const Recorder({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          (exercise as Exercise).exerciseType.name,
          style: const TextStyle(fontSize: 30),
        ),
        ...List.generate(
          (exercise as Exercise).sets,
          (index) => ExerciseSet(
            exercise: (exercise as Exercise),
            setNumber: index + 1,
          ),
        ),
      ],
    );
  }
}
