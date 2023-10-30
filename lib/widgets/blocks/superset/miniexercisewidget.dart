import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';

class MiniExerciseWidget extends StatefulWidget {
  final ExerciseType exerciseType;
  final VoidCallback onDelete;
  const MiniExerciseWidget(
      {super.key, required this.exerciseType, required this.onDelete});

  @override
  State<MiniExerciseWidget> createState() => _MiniExerciseWidgetState();
}

class _MiniExerciseWidgetState extends State<MiniExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    final ExerciseType exerciseType = widget.exerciseType;
    return Card(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            exerciseType.name,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          IconButton(
            onPressed: () {
              widget.onDelete();
            },
            splashColor: Colors.red,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
