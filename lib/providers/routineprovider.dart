import 'package:flutter/material.dart';
import 'package:gymmanager/providers/db/resources/exercise.dart';
import 'package:gymmanager/providers/db/resources/exercisecontainer.dart';
import 'package:gymmanager/widgets/blocks/exercise_widget.dart';
import 'package:gymmanager/widgets/blocks/superset/superset.dart';

class RoutineProvider extends ChangeNotifier {
  List<Object> data = [];
  List<Widget> routine = [];
  void deleteByKey(Key key) {
    for (var i = 0; i < data.length; i++) {
      Object o = data[i];
      if (o.runtimeType == Exercise) {
        if ((o as Exercise).key == key) {
          data.removeAt(i);
        } else {
          if ((o as ExerciseContainer).key == key) {
            data.removeAt(i);
          }
        }
        routine.removeAt(i);
        updateOrder();
      }
    }
  }

  void updateOrder() {
    int i = 0;
    for (Object o in data) {
      switch (o.runtimeType) {
        case Exercise:
          (o as Exercise).routineOrder = i;
        case ExerciseContainer:
          (o as ExerciseContainer).routineOrder = i;
      }
      i++;
    }
  }

  void add(Object o) {
    bool isExercise = o.runtimeType == Exercise;
    Key key = isExercise ? (o as Exercise).key : (o as ExerciseContainer).key;
    if (isExercise) {
      o = o as Exercise;
      data.add(o);
    } else {
      o = o as ExerciseContainer;
      data.add(o);
    }
    routine.add(Dismissible(
      key: key,
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        int length = routine.length;
        for (var i = 0; i < length; i++) {
          if (routine[i].key == key) {
            deleteByKey(key);
            notifyListeners();
          }
        }
      },
      child: isExercise
          ? ExerciseWidget(
              dropsetSwitch: () {
                (o as Exercise).dropset = !o.dropset;
              },
              exercise: o as Exercise,
            )
          : SuperSet(superset: o as ExerciseContainer),
    ));
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Widget item = routine.removeAt(oldIndex);
    routine.insert(newIndex, item);
    notifyListeners();
    updateOrder();
  }
}
