import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/functions/displaytime.dart';
import 'package:gymmanager/providers/routineplayprovider.dart';
import 'package:gymmanager/widgets/routines/stats/recorder.dart';
import 'package:gymmanager/widgets/infobutton.dart';
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
  int page = 0;
  final PageController pc = PageController(initialPage: 0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    RoutinePlayProvider provider = Provider.of<RoutinePlayProvider>(context);
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
          Expanded(
            flex: 1,
            child: Material(
              color: const Color.fromARGB(255, 82, 89, 183),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      displayTime(Duration(seconds: provider.time)),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        pc.previousPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut);
                        page = pc.page!.toInt();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      splashRadius: 25,
                    ),
                    IconButton(
                      onPressed: () {
                        pc.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                        );
                        page = pc.page!.toInt();
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      splashRadius: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: provider.timerActive
                ? PageView(
                    controller: pc,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      widget.exercises.length,
                      (index) => Recorder(exercise: widget.exercises[index]),
                    ),
                  )
                : const Placeholder(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (provider.subscription == null) {
            provider.initializeTimer(0, widget.routine);
          } else {
            provider.toggleTimer();
          }
        },
        child: provider.timerActive
            ? const Icon(Icons.pause)
            : const Icon(Icons.play_arrow),
      ),
    );
  }
}
