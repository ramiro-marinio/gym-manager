import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:sqflite/sqflite.dart';

Future<ExerciseType> getExerciseType(int id, Database db) async {
  Map<String, Object?> exerciseTypeMap =
      (await db.query("ExerciseTypes", where: "Id=$id"))[0];
  ExerciseType exerciseType = ExerciseType(
    id: exerciseTypeMap["Id"] as int,
    name: exerciseTypeMap["Name"] as String,
    description: exerciseTypeMap["Description"] as String,
    repunit: exerciseTypeMap["RepUnit"] as int == 1,
  );
  return exerciseType;
}
