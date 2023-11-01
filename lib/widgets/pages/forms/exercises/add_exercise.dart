import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymmanager/providers/db/resources/exercisetype.dart';
import 'package:gymmanager/widgets/pages/forms/exercises/create_exercise.dart';

class AddExercise extends StatefulWidget {
  final Function(ExerciseType exerciseType) onChoose;
  final List<ExerciseType> exercises;
  const AddExercise(
      {super.key, required this.onChoose, required this.exercises});

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  TextEditingController controller = TextEditingController();
  List<ExerciseType>? shown;
  String search = "";
  @override
  Widget build(BuildContext context) {
    List<ExerciseType> exercises = widget.exercises;
    shown ??= widget.exercises;
    if (exercises.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Select an execise"),
        ),
        body: Builder(
          builder: (context) {
            List<Widget> renderedExercises = [];
            for (ExerciseType exercise in shown!) {
              renderedExercises.add(
                ListTile(
                  onTap: () {
                    widget.onChoose(exercise);
                    Navigator.pop(context);
                  },
                  splashColor: const Color.fromARGB(100, 0, 0, 0),
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
                    splashColor: const Color.fromARGB(100, 0, 0, 0),
                    splashRadius: 25,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateExercise(
                              modifyMode: true,
                              exercise: exercise,
                            ),
                          ));
                    },
                  ),
                  title: Text(exercise.name),
                  subtitle: Text(
                    exercise.description.replaceAll(RegExp("\n"), " "),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
              renderedExercises.add(
                const Divider(
                  color: Color.fromARGB(150, 0, 0, 0),
                  thickness: 1,
                ),
              );
            }
            return ListView(
              children: [
                TextField(
                  controller: controller,
                  decoration:
                      const InputDecoration(prefixIcon: Icon(Icons.search)),
                  onChanged: (value) {
                    search = value;
                    shown = [];
                    setState(() {
                      for (ExerciseType ex in exercises) {
                        if (ex.name
                            .toUpperCase()
                            .contains(value.toUpperCase())) {
                          shown!.add(ex);
                        }
                      }
                    });
                  },
                ),
                Visibility(
                  visible: search.isNotEmpty,
                  child: Container(
                    color: const Color.fromARGB(150, 0, 0, 0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateExercise(
                              modifyMode: false,
                              exercise: ExerciseType(
                                name: search.trim(),
                                description: "",
                                repunit: true,
                              ),
                              onFinish: () {
                                setState(() {
                                  controller.clear();
                                  search = "";
                                  shown = exercises;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      splashColor: Colors.white,
                      textColor: Colors.white,
                      leading: const Icon(
                        Icons.add_circle,
                        color: Colors.green,
                        size: 35,
                      ),
                      title: const Text("No exercise?"),
                      subtitle: Text("Create exercise \"${search.trim()}\""),
                    ),
                  ),
                ),
                ...renderedExercises,
              ],
            );
          },
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text("No Exercises")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "You have no exercises!",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              const Text("Go to the Exercises Manager section to create one."),
              ElevatedButton(
                  onPressed: () => context.push('/exercises'),
                  child: const Text("GO")),
            ],
          ),
        ),
      );
    }
  }
}
