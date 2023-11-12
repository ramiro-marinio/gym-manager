import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:sqflite/sqflite.dart';

Future<List<Exercise>> generateExercises(
    Database db, List<Map<String, Object?>> maps) async {
  List<Exercise> result = [];
  for (var i = 0; i < maps.length; i++) {
    Map<String, Object?> map = maps[i];
    Map<String, Object?> exerciseTypeMap = (await db.query("ExerciseTypes",
        where: "Id=${map["ExerciseType"]}"))[0];
    ExerciseType exerciseType = ExerciseType(
      id: exerciseTypeMap["Id"] as int,
      name: exerciseTypeMap["Name"] as String,
      description: exerciseTypeMap["Description"] as String,
      repunit: exerciseTypeMap["RepUnit"] as int == 1,
    );
    Exercise resultExercise = Exercise(
        exerciseType: exerciseType,
        amount: map["Amount"] as int,
        sets: map["Sets"] as int,
        dropset: map["Dropset"] as int == 1,
        supersetted: map["Supersetted"] as int == 1,
        id: map["Id"] as int,
        parent: map["Parent"] as int,
        routineOrder: map["RoutineOrder"] as int);
    result.add(
      resultExercise,
    );
  }
  return result;
}
