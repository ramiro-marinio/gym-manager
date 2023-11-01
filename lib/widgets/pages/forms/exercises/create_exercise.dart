import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gymmanager/providers/db/resources/exercisetype.dart';
import 'package:gymmanager/providers/db/dbprovider.dart';
import 'package:provider/provider.dart';

class CreateExercise extends StatefulWidget {
  final ExerciseType? exercise;
  final bool modifyMode;
  final VoidCallback? onFinish;
  const CreateExercise(
      {super.key, this.exercise, required this.modifyMode, this.onFinish});

  @override
  State<CreateExercise> createState() => _CreateExerciseState();
}

class _CreateExerciseState extends State<CreateExercise> {
  final _formKey = GlobalKey<FormState>();
  final titleStyle = const TextStyle(fontWeight: FontWeight.w900, fontSize: 30);
  TextEditingController? namecontroller;
  TextEditingController? descriptioncontroller;
  bool? val;
  @override
  Widget build(BuildContext context) {
    namecontroller ??= TextEditingController(text: widget.exercise?.name);
    descriptioncontroller ??=
        TextEditingController(text: widget.exercise?.description);
    val ??= widget.exercise != null ? widget.exercise!.repunit : true;
    return Scaffold(
      appBar: AppBar(
          title: Text(!widget.modifyMode
              ? "Create an Exercise"
              : "Modify ${widget.exercise!.name}")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Exercise Name",
                    style: titleStyle,
                  ),
                  Card(
                    color: Colors.transparent,
                    child: TextFormField(
                      controller: namecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'The exercise\'s name cannot be empty.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Text(
                    "Description",
                    style: titleStyle,
                  ),
                  Card(
                    color: Colors.transparent,
                    child: TextFormField(
                      controller: descriptioncontroller,
                      maxLines: 15,
                    ),
                  ),
                  Text(
                    "Exercise Unit",
                    style: titleStyle,
                  ),
                  Card(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        const Icon(Icons.timer),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Transform.scale(
                            scale: 1.3,
                            child: Switch(
                              value: val!,
                              onChanged: (value) {
                                setState(() {
                                  val = !val!;
                                });
                              },
                            ),
                          ),
                        ),
                        const Icon(Icons.fitness_center),
                        Expanded(
                          child: AutoSizeText(
                            "The exercise will be measured in ${val! ? 'reps' : 'time'}",
                            style: const TextStyle(fontSize: 20),
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (!widget.modifyMode) {
                          context.read<DbProvider>().createExercise(
                                ExerciseType(
                                  name: namecontroller!.text,
                                  description: descriptioncontroller!.text,
                                  repunit: val!,
                                ),
                              );
                        } else {
                          context.read<DbProvider>().modifyExercise(
                                ExerciseType(
                                  id: widget.exercise!.id,
                                  name: namecontroller!.text,
                                  description: descriptioncontroller!.text,
                                  repunit: val!,
                                ),
                              );
                        }
                        if (widget.onFinish != null) {
                          widget.onFinish!();
                        }
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(!widget.modifyMode ? Icons.add : Icons.edit),
                    label: Text(
                      widget.exercise == null
                          ? "CREATE EXERCISE"
                          : "MODIFY EXERCISE",
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
