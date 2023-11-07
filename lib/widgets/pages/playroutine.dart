import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/routineplayprovider.dart';
import 'package:gymmanager/widgets/blocks/exercise_recording/recorder.dart';
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
  final PageController pc = PageController();
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
          Flexible(
            flex: 1,
            child: Material(
              color: const Color.fromARGB(255, 82, 89, 183),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        pc.previousPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut);
                      },
                      icon: const Icon(Icons.arrow_back),
                      splashRadius: 25,
                    ),
                    IconButton(
                      onPressed: () {
                        pc.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                        );
                      },
                      icon: const Icon(Icons.arrow_forward),
                      splashRadius: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: PageView(
                controller: pc,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  widget.exercises.length,
                  (index) => Recorder(exercise: widget.exercises[index]),
                )),
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
