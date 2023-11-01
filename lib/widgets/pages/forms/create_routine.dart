import 'package:flutter/material.dart';
import 'package:gymmanager/providers/db/dbprovider.dart';
import 'package:gymmanager/providers/db/resources/exercise.dart';
import 'package:gymmanager/providers/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/db/resources/exercisetype.dart';
import 'package:gymmanager/providers/routineprovider.dart';
import 'package:gymmanager/widgets/blocks/add_menu.dart';
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
  @override
  Widget build(BuildContext context) {
    List<Widget> routine = context.watch<RoutineProvider>().routine;
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
                          Exercise e = Exercise(
                            exerciseType: exerciseType,
                            amount: TextEditingController(),
                            sets: TextEditingController(),
                            routineOrder: routine.length,
                            dropset: false,
                            supersetted: false,
                            key: key,
                          );
                          context.read<RoutineProvider>().add(e);
                        },
                        exercises: exs,
                      );
                    },
                  ),
                );
              },
              addSuperset: () {
                Key key = UniqueKey();
                ExerciseContainer ss =
                    ExerciseContainer(isRoutine: false, key: key);
                context.read<RoutineProvider>().add(ss);
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
                  context.read<RoutineProvider>().reorder(oldIndex, newIndex);
                },
                children: routine,
              ),
      ),
    );
  }
}
