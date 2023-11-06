import 'package:gymmanager/providers/db/resources/exercisetype.dart';

class Exercise {
  final int? id;
  final ExerciseType exerciseType;
  int amount;
  int sets;
  int? routineOrder;
  bool dropset;
  bool supersetted;
  int? parent;
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
  Map<String, dynamic> toJson() {
    return id != null
        ? {
            'Id': id,
            'ExerciseType': exerciseType.id,
            'Amount': amount,
            'Sets': sets,
            'RoutineOrder': routineOrder,
            'Dropset': dropset ? 1 : 0,
            'Supersetted': supersetted ? 1 : 0,
            'Parent': parent,
          }
        : {
            'ExerciseType': exerciseType.id,
            'Amount': amount,
            'Sets': sets,
            'RoutineOrder': routineOrder,
            'Dropset': dropset ? 1 : 0,
            'Supersetted': supersetted ? 1 : 0,
            'Parent': parent,
          };
  }
}
