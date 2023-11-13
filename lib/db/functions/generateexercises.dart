import 'package:gymmanager/db/functions/getexercisetype.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:sqflite/sqflite.dart';

Future<List<Exercise>> generateExercises(
    Database db, List<Map<String, Object?>> maps) async {
  List<Exercise> result = [];
  for (var i = 0; i < maps.length; i++) {
    Map<String, Object?> map = maps[i];

    Exercise resultExercise = Exercise(
        exerciseType: await getExerciseType(map["ExerciseType"] as int, db),
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
