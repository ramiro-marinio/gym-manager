import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/dbprovider.dart';
import 'package:gymmanager/providers/routineplayprovider.dart';
import 'package:gymmanager/widgets/routines/stats/functions/generatesets.dart';
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
    //recorderPages is what is displaye in the entire page: the widgets that record statistics. I placed them in the provider
    //so that I could avoid them being deleted every reload and losing their data every time.
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
                  "This section of the app allows you to time your routines and see your last weight, so that when you do them, you do not have to remember what weight you used. It also guides you through the routine, so you don't need to remember the order.",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("End Routine?"),
              content: const Text("Make sure you inserted the correct data!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("NO"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    routinePlayProvider.endRoutine(
                      dbProvider: context.read<DbProvider>(),
                      context: context,
                    );
                  },
                  child: const Text("YES"),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
