import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/routineplayprovider.dart';
import 'package:gymmanager/widgets/routines/playroutine.dart';
import 'package:gymmanager/widgets/routines/view_routine/widgets/showroutine.dart';
import 'package:provider/provider.dart';

class RoutineWidget extends StatefulWidget {
  final ExerciseContainer routine;
  final List<Object> exercises;
  const RoutineWidget(
      {super.key, required this.routine, required this.exercises});

  @override
  State<RoutineWidget> createState() => _RoutineWidgetState();
}

class _RoutineWidgetState extends State<RoutineWidget> {
  @override
  Widget build(BuildContext context) {
    RoutinePlayProvider routinePlayProvider =
        Provider.of<RoutinePlayProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Card(
        child: Column(
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.routine.name!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Tooltip(
                  message: "Edit Routine",
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    splashRadius: 25,
                    splashColor: const Color.fromARGB(150, 33, 149, 243),
                  ),
                ),
                Tooltip(
                  message: "Start Routine",
                  //THIS BUTTON IS THE ROUTINE PLAYER
                  child: IconButton(
                    onPressed: () {
                      routinePlayProvider.currentRoutine ??= widget.routine;
                      if (routinePlayProvider.currentRoutine!.id ==
                          widget.routine.id) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayRoutine(
                              routine: widget.routine,
                              exercises: widget.exercises,
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Warning"),
                            content: const Text(
                                "You are already doing a different routine. If you start this one, your current routine will be aborted and the data will not be saved. Are you sure you want to proceed?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("NO")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    routinePlayProvider.stop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlayRoutine(
                                          routine: widget.routine,
                                          exercises: widget.exercises,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text("YES"))
                            ],
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.play_arrow),
                    splashRadius: 25,
                    splashColor: const Color.fromARGB(150, 76, 175, 79),
                  ),
                ),
                Tooltip(
                  message: "Delete Routine",
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                    splashRadius: 25,
                    splashColor: const Color.fromARGB(150, 244, 67, 54),
                  ),
                ),
                Tooltip(
                  message: "View Details",
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ShowRoutine(routine: widget.exercises);
                        },
                      ));
                    },
                    icon: const Icon(Icons.remove_red_eye),
                    splashRadius: 25,
                    splashColor: const Color.fromARGB(150, 155, 39, 176),
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
