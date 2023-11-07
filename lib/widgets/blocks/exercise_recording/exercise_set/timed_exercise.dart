import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/functions/displaytime.dart';
import 'package:gymmanager/widgets/blocks/time_setter.dart';

class TimeExercise extends StatefulWidget {
  final int setNumber;
  final Exercise exercise;
  const TimeExercise(
      {super.key, required this.setNumber, required this.exercise});

  @override
  State<TimeExercise> createState() => _TimeExerciseState();
}

class _TimeExerciseState extends State<TimeExercise> {
  int seconds = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Column(
          children: [
            Text(
              "Set ${widget.setNumber}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              "Expected time:${displayTime(Duration(seconds: widget.exercise.amount))}",
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => TimeSetter(
                    setTime: (time) {
                      setState(() {
                        seconds = time;
                      });
                    },
                  ),
                );
              },
              child: Card(
                color: Colors.transparent,
                child: Text(
                  displayTime(Duration(seconds: seconds)),
                  style: const TextStyle(fontSize: 20, letterSpacing: 1.5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
