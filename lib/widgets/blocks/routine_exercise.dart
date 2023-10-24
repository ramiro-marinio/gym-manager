import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/widgets/blocks/time_setter.dart';

class RoutineExercise extends StatefulWidget {
  final Exercise exercise;
  const RoutineExercise({super.key, required this.exercise});

  @override
  State<RoutineExercise> createState() => _RoutineExerciseState();
}

class _RoutineExerciseState extends State<RoutineExercise> {
  bool dropset = false;
  int amount = 0;
  String displayTime(int secs) {
    int seconds = secs % 60;
    int minutes = (secs - seconds) ~/ 60;
    return seconds >= 10 ? '$minutes:$seconds' : '$minutes:0$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final double scrwidth = MediaQuery.of(context).size.width;
    Exercise exercise = widget.exercise;
    bool unit = exercise.exerciseType.repunit;
    return Card(
      color: Colors.transparent,
      child: SizedBox(
        width: scrwidth * 0.9,
        height: 100,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                exercise.exerciseType.name,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
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
                        ? TextField(
                            enabled: !dropset,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                          )
                        : Card(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return TimeSetter(
                                      setTime: (int seconds) {
                                        setState(() {
                                          amount = seconds;
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                              child: Center(
                                child: AutoSizeText(
                                  displayTime(amount),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            //Sets adjuster
            const Positioned(
              top: 65,
              left: 10,
              child: Row(
                children: [
                  Text(
                    "Sets:",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 40,
                    height: 20,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                ],
              ),
            ),
            //Dropset title an info
            Positioned(
              top: 15,
              right: scrwidth * 0.1,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Drop Sets"),
                            content: const Text(
                                "When an exercise is \"drop-setted\", it means that instead of attempting to do a fixed amount of reps or time, one will repeat the exercise until muscle failure."),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK"))
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.info,
                    ),
                    splashColor: Colors.blue,
                    splashRadius: 25,
                  ),
                  const Text(
                    "Dropsetted:",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            //Dropset Switch
            Positioned(
              right: scrwidth * 0.15,
              top: 45,
              child: Switch(
                value: dropset,
                onChanged: (value) {
                  setState(() {
                    dropset = !dropset;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
