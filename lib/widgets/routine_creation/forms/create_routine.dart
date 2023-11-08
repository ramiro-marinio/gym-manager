import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gymmanager/providers/dbprovider.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:gymmanager/providers/routinecreationprovider.dart';
import 'package:gymmanager/widgets/routine_creation/widgets/add_menu.dart';
import 'package:gymmanager/widgets/routine_creation/forms/exercises/add_exercise.dart';
import 'package:gymmanager/widgets/routine_creation/widgets/no_exercises.dart';
import 'package:provider/provider.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({super.key});

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Widget> routine = context.watch<CreationProvider>().routine;
    List<ExerciseType> exs = context.watch<DbProvider>().exercises;
    final formKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Quit?"),
              content: const Text(
                  "If you quit. The routine you are building will not be saved. Proceed anyway?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("NO")),
                TextButton(
                    onPressed: () {
                      context.read<CreationProvider>().routine.clear();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text("YES")),
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
                            amount: 0,
                            sets: 0,
                            dropset: false,
                            supersetted: false,
                          );
                          context.read<CreationProvider>().add(e, key);
                        },
                        exercises: exs,
                      );
                    },
                  ),
                );
              },
              addSuperset: () {
                Key key = UniqueKey();
                ExerciseContainer supersetcontainer =
                    ExerciseContainer(isRoutine: false, sets: 1, children: []);
                context.read<CreationProvider>().add(supersetcontainer, key);
              },
            )
          ],
        ),
        body: ReorderableListView(
          header: Form(
            key: formKey,
            child: Column(
              children: [
                const Padding(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please insert a name";
                      }
                      return null;
                    },
                    maxLength: 50,
                    controller: name,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: "Routine Name",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ),
                const Gap(5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: description,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        hintText: "Description",
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2))),
                    maxLines: 4,
                  ),
                ),
                Visibility(
                  visible: routine.isEmpty,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: NoExercises(),
                  ),
                )
              ],
            ),
          ),
          onReorder: (oldIndex, newIndex) {
            context.read<CreationProvider>().reorder(oldIndex, newIndex);
          },
          children: routine,
        ),
        floatingActionButton: routine.isNotEmpty
            ? FloatingActionButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<CreationProvider>().createRoutine(
                      context,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                                Text("Your routine was created successfully!"),
                              ],
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      name.text,
                      description.text,
                    );
                  }
                },
                child: const Icon(Icons.check),
              )
            : null,
      ),
    );
  }
}