import 'package:flutter/material.dart';
import 'package:gymmanager/db/dbprovider.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:gymmanager/widgets/blocks/routine_exercise.dart';
import 'package:gymmanager/widgets/pages/forms/exercises/add_exercise.dart';
import 'package:provider/provider.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({super.key});

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  List<Exercise> routine = [];
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
                                setState(() {
                                  routine.add(
                                    Exercise(
                                      exerciseType: exerciseType,
                                      amount: 1,
                                      sets: 1,
                                      dropset: false,
                                      supersetted: false,
                                    ),
                                  );
                                });
                              },
                              exercises: exs,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const PopupMenuItem(
                    child: Text("Add a Superset"),
                  ),
                ];
              },
            )
          ],
        ),
        body: Builder(
          builder: (context) {
            if (routine.isEmpty) {
              return const Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "No Exercises!",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Try adding some in the top-right button.",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              List<Widget> display = [];
              for (Exercise exercise in routine) {
                display.add(RoutineExercise(exercise: exercise));
              }
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Routine",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  ...display
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
