import 'package:flutter/material.dart';
import 'package:gymmanager/providers/db/resources/exercisetype.dart';

class Exercise {
  final int? id;
  final ExerciseType exerciseType;
  TextEditingController amount;
  TextEditingController sets;
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
            'Amount': int.parse(amount.text),
            'Sets': int.parse(sets.text),
            'RoutineOrder': routineOrder,
            'Dropset': dropset ? 1 : 0,
            'Supersetted': supersetted ? 1 : 0,
            'Parent': parent,
          }
        : {
            'ExerciseType': exerciseType.id,
            'Amount': int.tryParse(amount.text) ?? 1,
            'Sets': int.tryParse(sets.text) ?? 1,
            'RoutineOrder': routineOrder,
            'Dropset': dropset ? 1 : 0,
            'Supersetted': supersetted ? 1 : 0,
            'Parent': parent,
          };
  }
}
