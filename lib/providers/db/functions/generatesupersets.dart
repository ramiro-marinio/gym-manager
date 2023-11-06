import 'package:gymmanager/providers/db/functions/generateexercises.dart';
import 'package:gymmanager/providers/db/resources/exercise.dart';
import 'package:gymmanager/providers/db/resources/exercisecontainer.dart';
import 'package:gymmanager/widgets/blocks/exercise_widget.dart';
import 'package:sqflite/sqflite.dart';

Future<List<ExerciseContainer>> generateSupersets(
    List<Map<String, Object?>> supersetMaps, Database db) async {
  List<ExerciseContainer> result = [];
  for (var i = 0; i < supersetMaps.length; i++) {
    Map<String, Object?> supersetMap = supersetMaps[i];
    List<Map<String, Object?>> childrenMaps =
        await db.query("Exercises", where: "Parent=${supersetMap["Id"]}");
    List<Exercise> exercises = await generateExercises(db, childrenMaps);
    result.add(
      ExerciseContainer(
        isRoutine: false,
        children: List.generate(
          exercises.length,
          (index) => ExerciseWidget(
            exercise: exercises[index],
            dropsetSwitch: () {
              exercises[index].dropset = !exercises[index].dropset;
            },
          ),
        ),
      ),
    );
  }
  return result;
}
