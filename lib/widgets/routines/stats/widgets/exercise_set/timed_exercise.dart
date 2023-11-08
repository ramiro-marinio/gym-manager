import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercise_recording/setrecord.dart';
import 'package:gymmanager/functions/displaytime.dart';
import 'package:gymmanager/widgets/routines/time_setter.dart';

class TimeExercise extends StatefulWidget {
  final int setNumber;
  final Exercise exercise;
  final SetRecord record;
  const TimeExercise({
    super.key,
    required this.setNumber,
    required this.exercise,
    required this.record,
  });

  @override
  State<TimeExercise> createState() => _TimeExerciseState();
}

class _TimeExerciseState extends State<TimeExercise> {
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
                        widget.record.amount = time;
                      });
                    },
                  ),
                );
              },
              child: Card(
                color: Colors.transparent,
                child: Text(
                  displayTime(Duration(seconds: widget.record.amount)),
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
