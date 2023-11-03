import 'package:flutter/material.dart';
import 'package:gymmanager/providers/db/dbprovider.dart';
import 'package:gymmanager/providers/db/resources/exercise.dart';
import 'package:gymmanager/providers/db/resources/exercisecontainer.dart';
import 'package:gymmanager/widgets/blocks/exercise_widget.dart';
import 'package:gymmanager/widgets/blocks/superset/superset.dart';
import 'package:provider/provider.dart';

class RoutineProvider extends ChangeNotifier {
  //List<Object> data = [];
  List<Dismissible> routine = [];
  void deleteByKey(Key key) {
    for (var i = 0; i < routine.length; i++) {
      Widget w = routine[i];
      if (w.key == key) {
        routine.removeAt(i);
      }
    }
  }

  void add(Object o, Key key) {
    bool isExercise = o.runtimeType == Exercise;
    routine.add(Dismissible(
      key: key,
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        deleteByKey(key);
        notifyListeners();
      },
      child: isExercise
          ? ExerciseWidget(
              dropsetSwitch: () {
                o.dropset = !o.dropset;
              },
              exercise: o as Exercise,
            )
          : SuperSet(
              superset: o as ExerciseContainer,
              key: key,
            ),
    ));
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Dismissible item = routine.removeAt(oldIndex);
    routine.insert(newIndex, item);
    notifyListeners();
  }

  void createRoutine(BuildContext context) async {
    final DbProvider dbprovider = context.read<DbProvider>();
    int routineId =
        await dbprovider.createRoutine(ExerciseContainer(isRoutine: true));
    List<Widget> realRoutine =
        List.generate(routine.length, (index) => routine[index].child);
  }
}
