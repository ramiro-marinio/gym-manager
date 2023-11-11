import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/routineplayprovider.dart';
import 'package:gymmanager/widgets/routines/stats/generatesets.dart';
import 'package:gymmanager/widgets/routines/stats/recorder.dart';
import 'package:gymmanager/widgets/infobutton.dart';
import 'package:gymmanager/widgets/routines/stats/widgets/navigationbar.dart';
import 'package:provider/provider.dart';

class PlayRoutine extends StatefulWidget {
  final ExerciseContainer routine;
  final List<Object> exercises;
  const PlayRoutine(
      {super.key, required this.routine, required this.exercises});
  @override
  State<PlayRoutine> createState() => _PlayRoutineState();
}

class _PlayRoutineState extends State<PlayRoutine> {
  int counter = 0;
  final PageController pc = PageController(initialPage: 0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    RoutinePlayProvider routinePlayProvider =
        context.watch<RoutinePlayProvider>();
    if (routinePlayProvider.recorderPages.isEmpty) {
      routinePlayProvider.recorderPages = List.generate(
        widget.exercises.length,
        (index) => Recorder(
          object: widget.exercises[index],
          setRecorders: generateSets(
            widget.exercises[index],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routine.name!),
        actions: const [
          InfoButton(
              title: "Routine Player",
              text:
                  "In this section of the app, you can run your routine, save your progress in the statistics section, and look at it later. You can also time your routines!",
              icon: Icon(Icons.help))
        ],
      ),
      body: Column(
        children: [
          //StatefulBuilder allows for a dramatic increase in app performance
          StatefulBuilder(
            builder: (context, setState) => NavBar(
              timerButton: () {
                if (routinePlayProvider.subscription == null) {
                  routinePlayProvider.initializeTimer(0, widget.routine);
                } else {
                  routinePlayProvider.toggleTimer();
                }
              },
              previousPage: () {
                pc.previousPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                );
              },
              nextPage: () {
                pc.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
          Expanded(
            flex: 12,
            child: PageView(
              controller: pc,
              physics: const NeverScrollableScrollPhysics(),
              children: routinePlayProvider.recorderPages,
            ),
          ),
        ],
      ),
    );
  }
}
