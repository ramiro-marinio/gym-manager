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
                          return AddExercise(
                            onChoose: (exerciseType) {
                              //TODO
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
    );
  }
}
