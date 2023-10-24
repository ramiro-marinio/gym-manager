import 'package:gymmanager/db/resources/exercisetype.dart';

class Exercise {
  final int? id;
  final ExerciseType exerciseType;
  int amount;
  int sets;
  int? routineOrder;
  bool dropset;
  bool supersetted;
  final int? parent;
  Exercise({
    this.id,
    required this.exerciseType,
    required this.amount,
    required this.sets,
    this.routineOrder,
    required this.dropset,
    required this.supersetted,
    this.parent,
  });
}
