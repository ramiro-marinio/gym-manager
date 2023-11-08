import 'package:flutter/material.dart';

class AddMenu extends StatelessWidget {
  final VoidCallback addExercise;
  final VoidCallback addSuperset;
  const AddMenu(
      {super.key, required this.addExercise, required this.addSuperset});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: addExercise,
            child: const Text("Add an Exercise"),
          ),
          PopupMenuItem(
            onTap: addSuperset,
            child: const Text("Add a Superset"),
          )
        ];
      },
    );
  }
}
