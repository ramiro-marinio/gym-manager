import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';

int sortMethod(a, b) {
  late int valA;
  late int valB;
  if (a.runtimeType == Exercise) {
    valA = (a as Exercise).routineOrder!;
  } else {
    valA = (a as ExerciseContainer).routineOrder!;
  }
  if (b.runtimeType == Exercise) {
    valB = (b as Exercise).routineOrder!;
  } else {
    valB = (b as ExerciseContainer).routineOrder!;
  }
  return valA.compareTo(valB);
}
