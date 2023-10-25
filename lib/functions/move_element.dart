import 'package:gymmanager/widgets/blocks/routine_exercise.dart';

List<RoutineExercise> moveElement(
    List<RoutineExercise> list, int index, int newposition,
    {bool moveToBeggining = false}) {
  if (index == newposition) {
    return list;
  }
  bool forward = newposition > index;
  List<RoutineExercise> listA = [];
  //This for loop adds every item that is not the "index" item, effectively removing it
  for (var i = 0; i < list.length; i++) {
    if (list[i] != list[index]) {
      listA += [list[i]];
    }
  }

  List<RoutineExercise> halfA = [];
  List<RoutineExercise> halfB = [];
  if (moveToBeggining == true) {
    return [list[index]] + listA;
  }
  if (forward) {
    newposition--;
  }
  halfA = listA.getRange(0, newposition + 1).toList();
  halfB = listA.getRange(newposition + 1, listA.length).toList();
  return halfA + [list[index]] + halfB;
}
