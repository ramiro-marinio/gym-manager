import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercise_recording/setrecord.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/widgets/routines/stats/widgets/exercise_set/exerciseset.dart';
import 'package:gymmanager/widgets/routines/stats/widgets/superset_set.dart';

List<Widget> generateSets(Object object) {
  return List.generate(
    object.runtimeType == Exercise
        ? (object as Exercise).sets
        : (object as ExerciseContainer).sets!,
    (index) {
      if (object.runtimeType == Exercise) {
        return ExerciseSet(
          exercise: (object as Exercise),
          label: "Set ${index + 1}",
          mini: false,
          record: SetRecord(
            exerciseType: (object).exerciseType,
            amount: 0,
            weight: 0,
          ),
        );
      }
      return SupersetSet(
        superset: object as ExerciseContainer,
        label: "Set ${index + 1}",
      );
    },
  );
}
