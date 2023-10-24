import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';

class RoutineExercise extends StatefulWidget {
  final Exercise exercise;
  const RoutineExercise({super.key, required this.exercise});

  @override
  State<RoutineExercise> createState() => _RoutineExerciseState();
}

class _RoutineExerciseState extends State<RoutineExercise> {
  bool dropset = false;

  @override
  Widget build(BuildContext context) {
    final double scrwidth = MediaQuery.of(context).size.width;
    Exercise exercise = widget.exercise;
    bool unit = exercise.exerciseType.repunit;
    return Card(
      color: Colors.transparent,
      child: SizedBox(
        width: scrwidth * 0.9,
        height: 100,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                exercise.exerciseType.name,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            Positioned(
              top: 40,
              left: 10,
              child: Row(
                children: [
                  Text(
                    unit ? "Reps:" : "Time:",
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 40,
                    height: 20,
                    child: TextField(
                      enabled: !dropset,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              top: 65,
              left: 10,
              child: Row(
                children: [
                  Text(
                    "Sets:",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 40,
                    height: 20,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 15,
                right: scrwidth * 0.1,
                child: Column(
                  children: [
                    const Text(
                      "Dropsetted:",
                      style: TextStyle(fontSize: 20),
                    ),
                    Switch(
                      value: dropset,
                      onChanged: (value) {
                        setState(() {
                          print(dropset);
                          dropset = !dropset;
                          print(dropset);
                        });
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
