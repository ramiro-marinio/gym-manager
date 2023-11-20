import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercise_recording/setrecord.dart';
import 'package:gymmanager/functions/displaytime.dart';
import 'package:gymmanager/widgets/routine_usage/time_setter.dart';

class TimeExercise extends StatefulWidget {
  final String label;
  final Exercise exercise;
  final SetRecord record;
  final bool mini;
  const TimeExercise({
    super.key,
    required this.label,
    required this.exercise,
    required this.record,
    required this.mini,
  });

  @override
  State<TimeExercise> createState() => _TimeExerciseState();
}

class _TimeExerciseState extends State<TimeExercise> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.mini ? 12.0 : 0.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Column(
            children: [
              Text(
                widget.label,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                "Expected time:${displayTime(duration: Duration(seconds: widget.exercise.amount), displayHours: false)}",
                style:
                    const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
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
                    displayTime(
                        duration: Duration(seconds: widget.record.amount),
                        displayHours: false),
                    style: const TextStyle(fontSize: 20, letterSpacing: 1.5),
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
