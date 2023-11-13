import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercise_recording/setrecord.dart';
import 'package:gymmanager/widgets/routines/stats/widgets/exercise_set/exerciseset.dart';
import 'package:gymmanager/widgets/routines/stats/widgets/exercise_set/statistics/statsview.dart';
import 'package:gymmanager/widgets/routines/stats/widgets/superset_set.dart';

//This object will generate each "set" for the user to record their data
class Recorder extends StatefulWidget {
  final Object object;
  final List<Widget> setRecorders;
  const Recorder({super.key, required this.object, required this.setRecorders});

  //This function is useful for when the routine is finished. It retrieves all the record objects to save them in the database ;)
  List<SetRecord> getRecords() {
    List<SetRecord> result = [];
    for (var i = 0; i < setRecorders.length; i++) {
      Widget recorderWidget = setRecorders[i];
      if (recorderWidget.runtimeType == ExerciseSet) {
        result.add((recorderWidget as ExerciseSet).record);
      } else {
        result += (recorderWidget as SupersetSet).getRecords();
      }
    }
    return result;
  }

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  List<Widget> sets = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            widget.object.runtimeType == Exercise
                ? (widget.object as Exercise).exerciseType.name
                : "Superset",
            style: const TextStyle(fontSize: 30),
          ),
          ...(widget.object.runtimeType == Exercise
              ? [StatsView(exercise: widget.object as Exercise)]
              : []),
          ...widget.setRecorders,
        ],
      ),
    );
  }
}
