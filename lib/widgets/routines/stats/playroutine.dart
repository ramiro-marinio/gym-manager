import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/routineplayprovider.dart';
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
    RoutinePlayProvider provider = context.read<RoutinePlayProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routine.name!),
        actions: const [
          InfoButton(
              title: "Routine Player",
              text:
                  "In this section of the app, you can run your rutine, save your progress in the statistics section and look at it later. You can also measure the time in your routine!",
              icon: Icon(Icons.help))
        ],
      ),
      body: Column(
        children: [
          StatefulBuilder(
            builder: (context, setState) => Expanded(
              flex: 1,
              child: NavBar(
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
          ),
          Expanded(
              flex: 12,
              child: PageView(
                controller: pc,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  widget.exercises.length,
                  (index) => Recorder(exercise: widget.exercises[index]),
                ),
              )),
        ],
      ),
      floatingActionButton: StatefulBuilder(
        builder: (context, setState) {
          RoutinePlayProvider statefulProvider =
              context.watch<RoutinePlayProvider>();
          return FloatingActionButton(
            onPressed: () {
              if (provider.subscription == null) {
                provider.initializeTimer(0, widget.routine);
              } else {
                provider.toggleTimer();
              }
            },
            child: statefulProvider.timerActive
                ? const Icon(Icons.pause)
                : const Icon(Icons.play_arrow),
          );
        },
      ),
    );
  }
}
