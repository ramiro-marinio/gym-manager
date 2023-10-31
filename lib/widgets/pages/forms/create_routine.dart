import 'package:flutter/material.dart';
import 'package:gymmanager/db/dbprovider.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:gymmanager/widgets/blocks/add_menu.dart';
import 'package:gymmanager/widgets/blocks/exercise_widget.dart';
import 'package:gymmanager/widgets/blocks/superset/superset.dart';
import 'package:gymmanager/widgets/pages/forms/exercises/add_exercise.dart';
import 'package:gymmanager/widgets/pages/forms/exercises/no_exercises.dart';
import 'package:gymmanager/widgets/blocks/exitalert.dart';
import 'package:provider/provider.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({super.key});

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  //The routine will hold all exercises and supersets
  List<Widget> routine = [];
  @override
  Widget build(BuildContext context) {
    List<ExerciseType> exs = context.watch<DbProvider>().exercises;
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return const ExitAlert();
          },
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create a routine"),
          actions: [
            AddMenu(
              addExercise: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddExercise(
                        onChoose: (exerciseType) {
                          Key key = UniqueKey();
                          int length = routine.length;
                          setState(
                            () {
                              routine.add(
                                Dismissible(
                                  key: key,
                                  background: Container(
                                    color: Colors.red,
                                    child: const Icon(Icons.delete),
                                  ),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) {
                                    for (var i = 0; i < length; i++) {}
                                  },
                                  child: ExerciseWidget(
                                    onDelete: () {},
                                    exercise: Exercise(
                                      exerciseType: exerciseType,
                                      amount: 1,
                                      routineOrder: routine.length,
                                      sets: 1,
                                      dropset: false,
                                      supersetted: false,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        exercises: exs,
                      );
                    },
                  ),
                );
              },
              addSuperset: () {
                Key key = UniqueKey();
                setState(
                  () {
                    routine.add(
                      Dismissible(
                        key: key,
                        direction: DismissDirection.startToEnd,
                        background: const Card(
                          color: Colors.red,
                          child: Icon(Icons.delete),
                        ),
                        onDismissed: (direction) {
                          for (var i = 0; i < routine.length; i++) {
                            if (routine[i].key == key) {
                              setState(() {
                                routine.removeAt(i);
                              });
                              break;
                            }
                          }
                        },
                        child: SuperSet(
                          superset: ExerciseContainer(isRoutine: false),
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
        body: routine.isEmpty
            ? const NoExercises()
            : ReorderableListView(
                header: const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Routine",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                footer: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check),
                  label: const Text("CREATE ROUTINE"),
                ),
                onReorder: (oldIndex, newIndex) {
                  setState(
                    () {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final Widget item = routine.removeAt(oldIndex);
                      routine.insert(newIndex, item);
                      for (var i = 0; i < routine.length; i++) {
                        if (routine[i].runtimeType == ExerciseWidget) {
                          (routine[i] as ExerciseWidget).exercise.routineOrder =
                              i;
                        } else {
                          (routine[i] as SuperSet).superset.routineOrder = i;
                        }
                      }
                    },
                  );
                },
                children: routine,
              ),
      ),
    );
  }
}
