import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/functions/displaytime.dart';

class ExerciseViewer extends StatelessWidget {
  final Exercise exercise;
  final bool mini;
  const ExerciseViewer({super.key, required this.exercise, required this.mini});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        color: Colors.lightBlue,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Icon(
                exercise.exerciseType.repunit
                    ? Icons.fitness_center
                    : Icons.timer,
                size: 30,
              ),
              Text(
                exercise.exerciseType.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${exercise.sets} set${exercise.sets > 1 ? "s" : ""} of ${exercise.exerciseType.repunit ? exercise.amount : displayTime(Duration(seconds: exercise.amount))}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
