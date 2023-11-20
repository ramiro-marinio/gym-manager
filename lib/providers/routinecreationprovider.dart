import 'package:flutter/material.dart';
import 'package:gymmanager/providers/dbprovider.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/widgets/routine_creation/widgets/exercise_widget.dart';
import 'package:gymmanager/widgets/routine_creation/widgets/superset/superset.dart';
import 'package:provider/provider.dart';

class CreationProvider extends ChangeNotifier {
  bool editMode = false;
  List<Dismissible> routine = [];
  List<Object> toDelete = [];
  void exitEditor() {
    routine.clear();
    toDelete.clear();
  }

  void deleteByKey(Key key) {
    for (var i = 0; i < routine.length; i++) {
      Widget w = routine[i];
      if (w.key == key) {
        routine.removeAt(i);
        if (editMode) {
          if (routine[i].child.runtimeType == ExerciseWidget) {
            Exercise exercise = (routine[i].child as ExerciseWidget).exercise;
            if (exercise.id != null) {
              toDelete.add(exercise);
            }
          } else {
            ExerciseContainer superset =
                (routine[i].child as SuperSet).superset;
            if (superset.id != null) {
              toDelete.add(superset);
              //It is not necessary to add the children because they are already deleted in the deleteExerciseContainer function
            }
          }
        }
        break;
      }
    }
  }

  void deleteByKeySuperset(ExerciseContainer superset, Key key) {
    for (Dismissible dismissible in routine) {
      if (dismissible.child.runtimeType == SuperSet) {
        SuperSet child = dismissible.child as SuperSet;
        int index = 0;
        int i = 0;
        for (ExerciseWidget ew in child.superset.children!) {
          if (ew.key == key) {
            index = i;
            break;
          }
          i++;
        }
        if (child.superset.children![index].exercise.id != null) {
          toDelete.add(child.superset.children![index].exercise);
        }
        child.superset.children!.removeAt(index);
        notifyListeners();
        break;
      }
    }
  }

  void add(Object o, Key key, int? reps, int sets, bool mounted) {
    if (o.runtimeType == Exercise) {
      o = o as Exercise;
      o.amount = reps!;
      o.sets = sets;
    } else {
      o = o as ExerciseContainer;
      o.sets = sets;
    }
    Widget child = o.runtimeType == Exercise
        ? ExerciseWidget(
            dropsetSwitch: () {
              (o as Exercise).dropset = !o.dropset;
            },
            exercise: o as Exercise,
          )
        : SuperSet(
            superset: o as ExerciseContainer,
            key: key,
          );
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
      child: child,
    ));
    if (mounted) {
      notifyListeners();
    }
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Dismissible item = routine.removeAt(oldIndex);
    routine.insert(newIndex, item);
    notifyListeners();
  }

  void createRoutine(BuildContext context, VoidCallback onComplete,
      ExerciseContainer routineDetails) async {
    final DbProvider dbprovider = context.read<DbProvider>();
    int routineId = await dbprovider.createRoutine(
      routine: routineDetails,
    );
    //"Real routine" because it is made of the exercises and exercise containers, not the widgets.
    List<Object> realRoutine = List.generate(routine.length, (index) {
      Widget widget = routine[index].child;
      return widget.runtimeType == ExerciseWidget
          ? (widget as ExerciseWidget).exercise
          : (widget as SuperSet).superset;
    });
    for (Object o in toDelete) {
      if (o.runtimeType == Exercise) {
        o = o as Exercise;
        dbprovider.deleteRoutineExercise(o.id!);
      } else {
        o = o as ExerciseContainer;
        dbprovider.deleteExerciseContainer(o.id!);
      }
    }
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
    exitEditor();
    onComplete();
  }
}
