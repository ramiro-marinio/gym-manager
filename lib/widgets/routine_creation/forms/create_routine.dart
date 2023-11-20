import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/routinecreationprovider.dart';
import 'package:gymmanager/widgets/routine_creation/widgets/add_menu.dart';
import 'package:gymmanager/widgets/routine_creation/forms/exercises/add_exercise.dart';
import 'package:gymmanager/widgets/routine_creation/widgets/no_exercises.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateRoutine extends StatefulWidget {
  final Map<String, Object>? editRoutine;
  const CreateRoutine({super.key, this.editRoutine});

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool initialized = false;
  @override
  Widget build(BuildContext context) {
    context.read<CreationProvider>().editMode = widget.editRoutine != null;
    if ((widget.editRoutine?['routine'] as ExerciseContainer?) != null) {
      nameController.text =
          (widget.editRoutine?['routine'] as ExerciseContainer).name!;
      descriptionController.text =
          (widget.editRoutine?['routine'] as ExerciseContainer).description!;
    }
    List<Widget> routine = context.watch<CreationProvider>().routine;
    if (widget.editRoutine != null && routine.isEmpty && !initialized) {
      for (Object o in widget.editRoutine!['children']! as List<Object>) {
        if (o.runtimeType == Exercise) {
          o = o as Exercise;
          context
              .read<CreationProvider>()
              .add(o, UniqueKey(), o.amount, o.sets, false);
        } else {
          o = o as ExerciseContainer;
          context
              .read<CreationProvider>()
              .add(o, UniqueKey(), null, o.sets!, false);
        }
      }
      initialized = true;
    }
    final formKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Quit?"),
              content: Text(
                  "If you quit. The routine you are ${widget.editRoutine == null ? "building" : "editing"} will not be saved. Proceed anyway?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("NO")),
                TextButton(
                    onPressed: () {
                      context.read<CreationProvider>().exitEditor();
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
          title: Text(widget.editRoutine == null
              ? "Create a routine"
              : "Edit routine \"${(widget.editRoutine!['routine'] as ExerciseContainer).name}\""),
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
                          context.read<CreationProvider>().add(
                              e,
                              key,
                              e.exerciseType.repunit ? 12 : 300,
                              e.exerciseType.repunit ? 4 : 1,
                              context.mounted);
                        },
                      );
                    },
                  ),
                );
              },
              addSuperset: () {
                Key key = UniqueKey();
                ExerciseContainer supersetcontainer =
                    ExerciseContainer(isRoutine: false, sets: 1, children: []);
                context
                    .read<CreationProvider>()
                    .add(supersetcontainer, key, null, 1, context.mounted);
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
                    controller: nameController,
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
                    controller: descriptionController,
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
                      ExerciseContainer(
                        id: (widget.editRoutine?['routine']
                                as ExerciseContainer?)
                            ?.id,
                        isRoutine: true,
                        creationDate: DateFormat("yyyy-MM-dd").format(
                          DateTime.now(),
                        ),
                        name: nameController.text,
                        description: descriptionController.text,
                      ),
                    );
                  }
                },
                child: widget.editRoutine == null
                    ? const Icon(Icons.check)
                    : const Icon(Icons.save),
              )
            : null,
      ),
    );
  }
}
