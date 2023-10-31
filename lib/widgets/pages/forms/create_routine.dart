import 'package:flutter/material.dart';
import 'package:gymmanager/db/dbprovider.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:gymmanager/widgets/blocks/exercise_widget.dart';
import 'package:gymmanager/widgets/blocks/superset/superset.dart';
import 'package:gymmanager/widgets/pages/forms/exercises/add_exercise.dart';
import 'package:gymmanager/widgets/pages/forms/exercises/no_exercises.dart';
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
            return AlertDialog(
              title: const Text("Leave?"),
              content: const Text(
                  "You are still building the routine. If you leave, it will not be saved. Proceed anyway?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Yes"),
                ),
              ],
            );
          },
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create a routine"),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text("Add an Exercise"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AddExercise(
                              onChoose: (exerciseType) {
                                Key key = UniqueKey();
                                setState(
                                  () {
                                    routine.add(
                                      ExerciseWidget(
                                        key: key,
                                        onDelete: () {
                                          for (var i = 0;
                                              i < routine.length;
                                              i++) {
                                            if (routine[i].key == key) {
                                              setState(() {
                                                routine.removeAt(i);
                                              });
                                              break;
                                            }
                                          }
                                        },
                                        exercise: Exercise(
                                          exerciseType: exerciseType,
                                          amount: 1,
                                          routineOrder: routine.length,
                                          sets: 1,
                                          dropset: false,
                                          supersetted: false,
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
                  ),
                  PopupMenuItem(
                    onTap: () {
                      Key key = UniqueKey();
                      setState(
                        () {
                          routine += [
                            SuperSet(
                              key: key,
                              onDelete: () {
                                for (var i = 0; i < routine.length; i++) {
                                  if (routine[i].key == key) {
                                    setState(() {
                                      routine.removeAt(i);
                                    });
                                    break;
                                  }
                                }
                              },
                              superset: ExerciseContainer(isRoutine: false),
                            )
                          ];
                        },
                      );
                    },
                    child: const Text("Add a Superset"),
                  ),
                ];
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
                          (routine[i] as SuperSet);
                        }
                      }
                    },
                  );
                },
                children:
                    List.generate(routine.length, (index) => routine[index]),
              ),
      ),
    );
  }
}
