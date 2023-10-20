import 'package:flutter/material.dart';
import 'package:gymmanager/db/dbprovider.dart';
import 'package:gymmanager/db/Exercise.dart';
import 'package:gymmanager/widgets/navdrawer.dart';
import 'package:gymmanager/widgets/pages/forms/create_exercise.dart';
import 'package:provider/provider.dart';

class ExerciseManager extends StatefulWidget {
  const ExerciseManager({super.key});

  @override
  State<ExerciseManager> createState() => _ExerciseManagerState();
}

class _ExerciseManagerState extends State<ExerciseManager> {
  @override
  Widget build(BuildContext context) {
    List<Exercise> exercises = context.watch<DbProvider>().exercises;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: const Text("My Exercises")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateExercise(),
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
                for (Exercise exercise in exercises) {
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
