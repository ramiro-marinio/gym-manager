import 'package:flutter/material.dart';
import 'package:gymmanager/providers/db/dbprovider.dart';
import 'package:gymmanager/providers/db/resources/exercisetype.dart';
import 'package:gymmanager/widgets/navdrawer.dart';
import 'package:gymmanager/widgets/pages/forms/exercises/create_exercise.dart';
import 'package:provider/provider.dart';

class ExerciseManager extends StatefulWidget {
  const ExerciseManager({super.key});

  @override
  State<ExerciseManager> createState() => _ExerciseManagerState();
}

class _ExerciseManagerState extends State<ExerciseManager> {
  @override
  Widget build(BuildContext context) {
    List<ExerciseType> exercises = context.watch<DbProvider>().exercises;
    double width = MediaQuery.of(context).size.width;
    final dbprovider = context.read<DbProvider>();
    return Scaffold(
        appBar: AppBar(title: const Text("My Exercises")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateExercise(
                  modifyMode: false,
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        drawer: const NavDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "My Exercises",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Builder(builder: (context) {
                List<Widget> widgets = [];
                for (ExerciseType exercise in exercises) {
                  widgets.add(
                    Card(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: width * 0.8,
                        height: 100,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Text(
                                exercise.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2,
                                  decorationStyle: TextDecorationStyle.double,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Positioned(
                              right: 25,
                              top: 25,
                              child: Icon(
                                exercise.repunit
                                    ? Icons.fitness_center
                                    : Icons.timer,
                                size: 50,
                              ),
                            ),
                            Positioned(
                              top: 50,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                const Text("Delete Exercise?"),
                                            content: const Text(
                                                "This exercise will disappear in all routines!"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("No"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  dbprovider.deleteExercise(
                                                    exercise.id!,
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Yes"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.delete),
                                    splashRadius: 25,
                                    splashColor:
                                        const Color.fromARGB(50, 255, 0, 0),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CreateExercise(
                                            exercise: exercise,
                                            modifyMode: true,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                    splashRadius: 25,
                                    splashColor:
                                        const Color.fromARGB(50, 0, 0, 255),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(exercise.name),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  const Text(
                                                    "Description:",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  Text(exercise.description),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.info),
                                    splashRadius: 25,
                                    splashColor:
                                        const Color.fromARGB(50, 0, 255, 0),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Column(
                  children: widgets,
                );
              }),
            ],
          ),
        ));
  }
}
