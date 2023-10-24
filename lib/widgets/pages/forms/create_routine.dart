import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/widgets/pages/forms/exercises/add_exercise.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({super.key});

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  List<Exercise> routine = [];
  @override
  Widget build(BuildContext context) {
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
              final double scrwidth = MediaQuery.of(context).size.width;
              List<Widget> display = [];
              for (Exercise exercise in routine) {
                bool unit = exercise.exerciseType.repunit;
                display.add(
                  Card(
                    color: Colors.transparent,
                    child: SizedBox(
                      width: scrwidth * 0.9,
                      height: 100,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Text(
                              exercise.exerciseType.name,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 10,
                            child: Row(
                              children: [
                                Text(
                                  unit ? "Reps:" : "Time:",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 60,
                                  height: 20,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            top: 65,
                            left: 10,
                            child: Row(
                              children: [
                                Text(
                                  "Sets:",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 60,
                                  height: 20,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    textAlignVertical: TextAlignVertical.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              top: 15,
                              right: scrwidth * 0.1,
                              child: Column(
                                children: [
                                  Text(
                                    "Dropsetted:",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Switch(
                                    value: false,
                                    onChanged: (value) {},
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                );
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
