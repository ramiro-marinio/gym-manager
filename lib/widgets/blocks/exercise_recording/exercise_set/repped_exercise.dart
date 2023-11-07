import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/widgets/infobutton.dart';

class RepsExercise extends StatefulWidget {
  final int setNumber;
  final Exercise exercise;
  const RepsExercise(
      {super.key, required this.setNumber, required this.exercise});

  @override
  State<RepsExercise> createState() => _RepsExerciseState();
}

class _RepsExerciseState extends State<RepsExercise> {
  int reps = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Column(
          children: [
            Text(
              "Set ${widget.setNumber}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Expected reps: ${widget.exercise.amount}",
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: reps.toDouble(),
                    max: widget.exercise.amount * 2,
                    label: reps.toString(),
                    divisions: widget.exercise.amount * 2 <= 60
                        ? widget.exercise.amount * 2
                        : null,
                    onChanged: (value) {
                      setState(() {
                        reps = value.toInt();
                      });
                    },
                  ),
                ),
                Visibility(
                    maintainAnimation: true,
                    maintainState: true,
                    maintainSize: true,
                    visible: reps > (widget.exercise.amount * 1.5).round() &&
                        widget.exercise.dropset == false,
                    child: const InfoButton(
                        title: "Excessive Reps",
                        text:
                            "You are doing many more reps than expected. This is not recommended, as you are probably not reaching muscle failure. Try using more weight, so that you get better results.",
                        icon: Icon(Icons.warning))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
