import 'package:gymmanager/db/resources/exercisetype.dart';

class ExerciseRecord {
  final int? id;
  final ExerciseType exerciseType;
  final int? recordId;
  int amount;
  int weight;
  int sets;
  ExerciseRecord(
      {this.id,
      this.recordId,
      required this.exerciseType,
      required this.amount,
      required this.weight,
      required this.sets});
}
