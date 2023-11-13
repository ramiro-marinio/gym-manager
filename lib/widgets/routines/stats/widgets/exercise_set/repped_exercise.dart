import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercise_recording/setrecord.dart';
import 'package:gymmanager/widgets/infobutton.dart';
import 'package:gymmanager/widgets/routines/stats/widgets/exercise_set/statistics/statsview.dart';

class RepsExercise extends StatefulWidget {
  final String label;
  final Exercise exercise;
  final SetRecord record;
  final bool mini;
  const RepsExercise({
    super.key,
    required this.label,
    required this.exercise,
    required this.record,
    required this.mini,
  });

  @override
  State<RepsExercise> createState() => _RepsExerciseState();
}

class _RepsExerciseState extends State<RepsExercise> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.mini ? 12.0 : 0.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StatsView(exercise: widget.exercise),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.query_stats),
                    splashRadius: 15,
                  )
                ],
              ),
              Text(
                !widget.exercise.dropset
                    ? "Expected reps: ${widget.exercise.amount}"
                    : "Dropset",
                style:
                    const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
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
                                controller: TextEditingController(
                                  text: widget.record.amount != 0
                                      ? widget.record.amount.toString()
                                      : null,
                                ),
                                onChanged: (value) {
                                  widget.record.amount =
                                      int.tryParse(value) ?? 0;
                                },
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 30,
                  child: TextField(
                    controller: TextEditingController(
                      text: widget.record.weight == 0
                          ? null
                          : widget.record.weight.toString(),
                    ),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Weight (kg)",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,1}')),
                      LengthLimitingTextInputFormatter(4),
                    ],
                    onChanged: (value) {
                      widget.record.weight = int.tryParse(value) != null
                          ? int.parse(value).toDouble()
                          : 0;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
