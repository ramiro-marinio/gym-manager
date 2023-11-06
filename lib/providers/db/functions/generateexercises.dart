import 'package:gymmanager/providers/db/resources/exercise.dart';
import 'package:gymmanager/providers/db/resources/exercisetype.dart';
import 'package:sqflite/sqflite.dart';

Future<List<Exercise>> generateExercises(
    Database db, List<Map<String, Object?>> maps) async {
  List<Exercise> result = [];
  print("THE LENGTH IS ${maps.length}");
  for (var i = 0; i < maps.length; i++) {
    Map<String, Object?> map = maps[i];
    Map<String, Object?> exerciseTypeMap = (await db.query("ExerciseTypes",
        where: "Id=${map["ExerciseType"]}"))[0];
    print("THE MAP IS $exerciseTypeMap");
    ExerciseType exerciseType = ExerciseType(
        name: exerciseTypeMap["Name"] as String,
        description: exerciseTypeMap["Description"] as String,
        repunit: exerciseTypeMap["RepUnit"] as bool);
    result.add(
      Exercise(
          exerciseType: exerciseType,
          amount: map["Amount"] as int,
          sets: map["Sets"] as int,
          dropset: map["Dropset"] as bool,
          supersetted: map["Supersetted"] as bool),
    );
  }
  return result;
}
