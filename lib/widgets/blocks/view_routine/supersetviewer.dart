import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/widgets/blocks/view_routine/exerciseviewer.dart';

class SupersetViewer extends StatelessWidget {
  final ExerciseContainer superset;
  const SupersetViewer({super.key, required this.superset});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 100, 100, 255),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Superset. ${superset.sets} set${superset.sets! > 1 ? "s" : ""}",
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                fontStyle: FontStyle.italic),
          ),
        ),
        ...List.generate(
          superset.children!.length,
          (index) => ExerciseViewer(
              exercise: superset.children![index].exercise, mini: true),
        ),
      ]),
    );
  }
}
