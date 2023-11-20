import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise_recording/setrecord.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/widgets/routine_usage/stats/widgets/exercise_set/exerciseset.dart';

class SupersetSet extends StatefulWidget {
  final ExerciseContainer superset;
  final String label;
  final List<ExerciseSet> supersetRecorderWdidgets;
  const SupersetSet({
    super.key,
    required this.superset,
    required this.label,
    required this.supersetRecorderWdidgets,
  });
  //This function retrieves the record objects in the superset so that the "bigger" getRecords can get all records.
  List<SetRecord> getRecords() {
    return List.generate(
      supersetRecorderWdidgets.length,
      (index) => supersetRecorderWdidgets[index].record,
    );
  }

  @override
  State<SupersetSet> createState() => _SupersetSetState();
}

class _SupersetSetState extends State<SupersetSet> {
  @override
  Widget build(BuildContext context) {
    widget.supersetRecorderWdidgets.sort(
      (a, b) {
        return a.exercise.routineOrder!.compareTo(b.exercise.routineOrder!);
      },
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: const Color.fromARGB(255, 27, 27, 82),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            ...widget.supersetRecorderWdidgets,
          ]),
        ),
      ),
    );
  }
}
