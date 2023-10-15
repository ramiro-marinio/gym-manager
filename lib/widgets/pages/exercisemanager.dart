import 'package:flutter/material.dart';
import 'package:gymmanager/widgets/navdrawer.dart';

class ExerciseManager extends StatefulWidget {
  const ExerciseManager({super.key});

  @override
  State<ExerciseManager> createState() => _ExerciseManagerState();
}

class _ExerciseManagerState extends State<ExerciseManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("My Exercises")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        drawer: const NavDrawer(),
        body: const Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "My Exercises",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ));
  }
}
