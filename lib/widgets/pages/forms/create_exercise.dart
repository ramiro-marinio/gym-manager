import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gymmanager/db/Exercise.dart';
import 'package:gymmanager/db/dbprovider.dart';
import 'package:provider/provider.dart';

class CreateExercise extends StatefulWidget {
  const CreateExercise({super.key});

  @override
  State<CreateExercise> createState() => _CreateExerciseState();
}

class _CreateExerciseState extends State<CreateExercise> {
  final _formKey = GlobalKey<FormState>();
  final titleStyle = const TextStyle(fontWeight: FontWeight.w900, fontSize: 30);
  TextEditingController namecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  bool val = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create an Exercise")),
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
                              value: val,
                              onChanged: (value) {
                                setState(() {
                                  val = !val;
                                });
                              },
                            ),
                          ),
                        ),
                        const Icon(Icons.fitness_center),
                        Expanded(
                          child: AutoSizeText(
                            "The exercise will be measured in ${val ? 'reps' : 'time'}",
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
                        context.read<DbProvider>().createExercise(
                              Exercise(
                                name: namecontroller.text,
                                description: descriptioncontroller.text,
                                repunit: val,
                              ),
                            );
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("CREATE EXERCISE"),
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
