import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercise_recording/setrecord.dart';
import 'package:gymmanager/widgets/infobutton.dart';

class RepsExercise extends StatefulWidget {
  final int setNumber;
  final Exercise exercise;
  final SetRecord record;
  const RepsExercise({
    super.key,
    required this.setNumber,
    required this.exercise,
    required this.record,
  });

  @override
  State<RepsExercise> createState() => _RepsExerciseState();
}

class _RepsExerciseState extends State<RepsExercise> {
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
              !widget.exercise.dropset
                  ? "Expected reps: ${widget.exercise.amount}"
                  : "Dropset",
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Row(
              children: [
                Expanded(
                  child: !widget.exercise.dropset
                      ? Slider(
                          value: widget.record.amount.toDouble(),
                          max: widget.exercise.amount * 2,
                          label: widget.record.amount.toString(),
                          divisions: widget.exercise.amount * 2 <= 60
                              ? widget.exercise.amount * 2
                              : null,
                          onChanged: (value) {
                            setState(() {
                              widget.record.amount = value.toInt();
                            });
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 30,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Reps",
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                              ),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                            ),
                          ),
                        ),
                ),
                Visibility(
                  maintainAnimation: !widget.exercise.dropset,
                  maintainState: !widget.exercise.dropset,
                  maintainSize: !widget.exercise.dropset,
                  visible: widget.record.amount >
                          (widget.exercise.amount * 1.2).round() &&
                      widget.exercise.dropset == false,
                  child: const InfoButton(
                    title: "Excessive Reps",
                    text:
                        "You are doing many more reps than expected. This is not recommended, as you are probably not reaching muscle failure. Try using more weight, so that you get better results.",
                    icon: Icon(Icons.warning),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
