import 'package:gymmanager/db/resources/exercisetype.dart';

class SetRecord {
  final int? id;
  final ExerciseType exerciseType;
  int? exerciseId;
  int? routineId;
  int amount;
  int weight;
  SetRecord({
    this.id,
    this.exerciseId,
    required this.exerciseType,
    required this.amount,
    required this.weight,
  });
}
