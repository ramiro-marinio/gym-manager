import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';

//This object will generate each "set" for the user to record their data
class Recorder extends StatefulWidget {
  final Object object;
  final List<Widget> setRecorders;
  const Recorder({super.key, required this.object, required this.setRecorders});

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
          ...widget.setRecorders,
        ],
      ),
    );
  }
}
