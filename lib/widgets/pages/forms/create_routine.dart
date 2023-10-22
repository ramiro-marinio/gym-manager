import 'package:flutter/material.dart';
import 'package:gymmanager/db/dbprovider.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:gymmanager/widgets/pages/forms/create_exercise.dart';
import 'package:provider/provider.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({super.key});

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          List<ExerciseType> exercises =
                              context.watch<DbProvider>().exercises;
                          return Scaffold(
                              appBar: AppBar(
                                title: const Text("Select an execise"),
                              ),
                              body: Builder(
                                builder: (context) {
                                  List<Widget> renderedExercises = [
                                    const TextField(
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.search)),
                                    )
                                  ];
                                  for (ExerciseType exercise in exercises) {
                                    renderedExercises.add(
                                      ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        splashColor:
                                            const Color.fromARGB(100, 0, 0, 0),
                                        leading: exercise.repunit
                                            ? const Icon(
                                                Icons.fitness_center,
                                                color: Colors.black,
                                              )
                                            : const Icon(
                                                Icons.timer,
                                                color: Colors.black,
                                              ),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                          ),
                                          splashColor: const Color.fromARGB(
                                              100, 0, 0, 0),
                                          splashRadius: 25,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreateExercise(
                                                    modifyMode: true,
                                                    exercise: exercise,
                                                  ),
                                                ));
                                          },
                                        ),
                                        title: Text(exercise.name),
                                        subtitle: Text(
                                          exercise.description
                                              .replaceAll(RegExp("\n"), " "),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    );
                                  }
                                  return ListView(
                                    children: renderedExercises,
                                  );
                                },
                              ));
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
    );
  }
}
