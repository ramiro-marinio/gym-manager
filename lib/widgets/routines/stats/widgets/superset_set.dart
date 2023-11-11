import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercise_recording/setrecord.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/widgets/routines/stats/widgets/exercise_set/exerciseset.dart';

class SupersetSet extends StatefulWidget {
  final ExerciseContainer superset;
  final String label;
  const SupersetSet({super.key, required this.superset, required this.label});

  @override
  State<SupersetSet> createState() => _SupersetSetState();
}

class _SupersetSetState extends State<SupersetSet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: const Color.fromARGB(255, 27, 27, 82),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            ...List.generate(
              widget.superset.children!.length,
              (index) {
                Exercise e = widget.superset.children![index].exercise;
                return ExerciseSet(
                  exercise: e,
                  label: "Exercise ${index + 1}: ${e.exerciseType.name}",
                  record: SetRecord(
                    exerciseType: e.exerciseType,
                    amount: 0,
                    weight: 0,
                  ),
                  mini: true,
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
