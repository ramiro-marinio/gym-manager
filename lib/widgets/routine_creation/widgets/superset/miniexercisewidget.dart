import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gymmanager/functions/displaytime.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:gymmanager/widgets/routine_creation/widgets/minitextfield.dart';
import 'package:gymmanager/widgets/routines/time_setter.dart';

class MiniExerciseWidget extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback onDelete;
  final VoidCallback dropsetSwitch;
  const MiniExerciseWidget({
    super.key,
    required this.exercise,
    required this.onDelete,
    required this.dropsetSwitch,
  });

  @override
  State<MiniExerciseWidget> createState() => _MiniExerciseWidgetState();
}

class _MiniExerciseWidgetState extends State<MiniExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    final Exercise exercise = widget.exercise;
    final ExerciseType exerciseType = exercise.exerciseType;
    return SizedBox(
      height: 70,
      child: Card(
        key: widget.key,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 100,
              child: AutoSizeText(
                exerciseType.name,
                maxLines: 2,
                wrapWords: false,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Stack(
                  children: [
                    const Positioned(
                      child: Text(
                        "Dropsetted:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 10,
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
            SizedBox(
              width: 40,
              height: exerciseType.repunit ? 20 : 25,
              child: exerciseType.repunit
                  ? MiniTextField(
                      changeHandler: (value) {
                        exercise.amount = int.tryParse(value) ?? 1;
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
                                          widget.exercise.amount = seconds;
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
                                    Duration(seconds: exercise.amount),
                                  )
                                : "-",
                          ),
                        ),
                      ),
                    ),
            ),
            IconButton(
              onPressed: () {
                widget.onDelete();
              },
              splashColor: Colors.red,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
