import 'package:flutter/material.dart';
import 'package:gymmanager/db/functions/generateexercises.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/routinecreationprovider.dart';
import 'package:gymmanager/widgets/routine_creation/widgets/exercise_widget.dart';
import 'package:sqflite/sqflite.dart';

Future<List<ExerciseContainer>> generateSupersets(
    List<Map<String, Object?>> supersetMaps,
    Database db,
    CreationProvider creationProvider) async {
  List<ExerciseContainer> result = [];
  for (var i = 0; i < supersetMaps.length; i++) {
    Map<String, Object?> supersetMap = supersetMaps[i];
    List<Map<String, Object?>> childrenMaps = await db.query("Exercises",
        where: "Parent=${supersetMap["Id"]} AND Supersetted=1");
    List<Exercise> exercises = await generateExercises(db, childrenMaps);
    ExerciseContainer superset = ExerciseContainer(
      routineOrder: supersetMap["RoutineOrder"] as int,
      id: supersetMap["Id"] as int,
      sets: supersetMap["Sets"] as int,
      isRoutine: false,
    );
    superset.children = List.generate(exercises.length, (index) {
      Key key = UniqueKey();
      ExerciseWidget result = ExerciseWidget(
        supersetMode: true,
        key: key,
        exercise: exercises[index],
        dropsetSwitch: () {
          exercises[index].dropset = !exercises[index].dropset;
        },
        superset: superset,
      );
      return result;
    });
    result.add(superset);
  }
  return result;
}
