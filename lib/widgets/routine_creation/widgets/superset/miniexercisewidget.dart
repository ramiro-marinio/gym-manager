import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/functions/displaytime.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:gymmanager/providers/routinecreationprovider.dart';
import 'package:gymmanager/widgets/routine_creation/widgets/minitextfield.dart';
import 'package:gymmanager/widgets/routine_usage/time_setter.dart';
import 'package:provider/provider.dart';

class SupersetExerciseWidget extends StatefulWidget {
  final Exercise exercise;
  final ExerciseContainer superset;
  final VoidCallback dropsetSwitch;
  final TextEditingController? controller;
  const SupersetExerciseWidget(
      {super.key,
      required this.exercise,
      required this.superset,
      required this.dropsetSwitch,
      this.controller});

  @override
  State<SupersetExerciseWidget> createState() => _SupersetExerciseWidgetState();
}

class _SupersetExerciseWidgetState extends State<SupersetExerciseWidget> {
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
                      controller: widget.controller,
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
                                    duration:
                                        Duration(seconds: exercise.amount),
                                    displayHours: false)
                                : "-",
                          ),
                        ),
                      ),
                    ),
            ),
            IconButton(
              onPressed: () {
                CreationProvider creationProvider =
                    context.read<CreationProvider>();
                creationProvider.deleteByKeySuperset(
                  widget.superset,
                  widget.key!,
                );
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
