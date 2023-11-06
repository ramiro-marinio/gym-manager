import 'package:flutter/material.dart';
import 'package:gymmanager/db/dbprovider.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/widgets/blocks/exercise_widget.dart';
import 'package:gymmanager/widgets/blocks/superset/superset.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreationProvider extends ChangeNotifier {
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
      child: o.runtimeType == Exercise
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

  void createRoutine(BuildContext context, VoidCallback onComplete, String name,
      String description) async {
    final DbProvider dbprovider = context.read<DbProvider>();
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    int routineId = await dbprovider.createRoutine(
      ExerciseContainer(
        isRoutine: true,
        creationDate: date,
        name: name,
        description: description,
      ),
    );
    //"Real routine" because it is made of the exercises and exercise containers, not the widgets.
    List<Object> realRoutine = List.generate(routine.length, (index) {
      Widget widget = routine[index].child;
      return widget.runtimeType == ExerciseWidget
          ? (widget as ExerciseWidget).exercise
          : (widget as SuperSet).superset;
    });
    int index = 0;
    for (Object o in realRoutine) {
      switch (o.runtimeType) {
        case Exercise:
          o = o as Exercise;
          o.routineOrder = index;
          o.parent = routineId;
          await dbprovider.createRoutineExercise(o);
        //dbprovider.createRoutineExercise(o);
        case ExerciseContainer:
          o = o as ExerciseContainer;
          o.parent = routineId;
          o.routineOrder = index;
          int supersetId = await dbprovider.createSuperset(o);
          int i = 0;
          for (ExerciseWidget ew in o.children!) {
            Exercise ex = ew.exercise;
            ex.supersetted = true;
            ex.routineOrder = i;
            ex.parent = supersetId;
            await dbprovider.createRoutineExercise(ex);
            i++;
          }
      }
      index++;
    }
    routine.clear();
    onComplete();
  }
}
