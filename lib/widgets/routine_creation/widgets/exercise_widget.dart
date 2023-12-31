import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/functions/displaytime.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/widgets/routine_creation/widgets/minitextfield.dart';
import 'package:gymmanager/widgets/routine_creation/widgets/superset/miniexercisewidget.dart';
import 'package:gymmanager/widgets/routine_usage/time_setter.dart';

class ExerciseWidget extends StatefulWidget {
  final ExerciseContainer? superset;
  final Exercise exercise;
  final VoidCallback dropsetSwitch;
  final bool supersetMode;
  final Function(Function())? setState;
  const ExerciseWidget(
      {super.key,
      required this.exercise,
      required this.dropsetSwitch,
      this.supersetMode = false,
      this.superset,
      this.setState});
  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    String result = exercise.dropset.toString();
    return result;
  }
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    final double scrwidth = MediaQuery.of(context).size.width;
    Exercise exercise = widget.exercise;
    bool unit = exercise.exerciseType.repunit;
    bool mini = widget.supersetMode;
    return mini == false
        ? SizedBox(
            width: scrwidth,
            child: Card(
              color: const Color.fromARGB(255, 160, 133, 255),
              child: SizedBox(
                height: 100,
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: SizedBox(
                        width: 170,
                        child: AutoSizeText(
                          exercise.exerciseType.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    //Reps or time adjuster
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
                            height: unit ? 20 : 25,
                            child: unit
                                ? MiniTextField(
                                    controller: TextEditingController(
                                        text:
                                            widget.exercise.amount.toString()),
                                    changeHandler: (String value) {
                                      exercise.amount =
                                          int.tryParse(value) ?? 1;
                                    },
                                    enabled: !exercise.dropset,
                                  )
                                : Card(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: !exercise.dropset
                                          ? () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return TimeSetter(
                                                    setTime: (int seconds) {
                                                      setState(() {
                                                        widget.exercise.amount =
                                                            seconds;
                                                      });
                                                    },
                                                  );
                                                },
                                              );
                                            }
                                          : null,
                                      child: Center(
                                        child: AutoSizeText(
                                          !exercise.dropset
                                              ? displayTime(
                                                  duration: Duration(
                                                    seconds: exercise.amount,
                                                  ),
                                                  displayHours: false)
                                              : "-",
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    //Sets adjuster
                    Positioned(
                      top: 65,
                      left: 10,
                      child: Row(
                        children: [
                          const Text(
                            "Sets:",
                            style: TextStyle(fontSize: 18),
                          ),
                          MiniTextField(
                            controller: TextEditingController(
                                text: widget.exercise.sets.toString()),
                            changeHandler: (value) {
                              exercise.sets = int.tryParse(value) ?? 1;
                            },
                          ),
                        ],
                      ),
                    ),
                    //Dropset title and info
                    Positioned(
                      top: 15,
                      right: scrwidth * 0.1,
                      child: const Text(
                        "Dropsetted:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    //Dropset Switch
                    Positioned(
                      right: scrwidth * 0.15,
                      top: 45,
                      child: Switch(
                        value: exercise.dropset,
                        onChanged: (value) {
                          setState(() {
                            widget.dropsetSwitch();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : SupersetExerciseWidget(
            key: widget.key,
            superset: widget.superset!,
            exercise: exercise,
            dropsetSwitch: widget.dropsetSwitch,
            controller:
                TextEditingController(text: widget.exercise.amount.toString()),
          );
  }
}
