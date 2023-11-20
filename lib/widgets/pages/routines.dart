import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/providers/dbprovider.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/routinecreationprovider.dart';
import 'package:gymmanager/widgets/routine_usage/home/routinewidget.dart';
import 'package:gymmanager/widgets/pages/navdrawer.dart';
import 'package:gymmanager/widgets/routine_creation/forms/create_routine.dart';
import 'package:provider/provider.dart';

class Routines extends StatefulWidget {
  const Routines({super.key});

  @override
  State<Routines> createState() => _RoutinesState();
}

class _RoutinesState extends State<Routines> {
  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, Object>>> routines = context
        .watch<DbProvider>()
        .getRoutines(context.watch<CreationProvider>());
    return Scaffold(
      appBar: AppBar(title: const Text("My Routines")),
      drawer: const NavDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateRoutine()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: routines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            for (Map map in snapshot.data!) {
              (map["exercises"] as List<Object>).sort(
                (a, b) {
                  int orderA = 0;
                  int orderB = 0;
                  if (a.runtimeType == Exercise) {
                    orderA = (a as Exercise).routineOrder!;
                  } else {
                    orderA = (a as ExerciseContainer).routineOrder!;
                  }
                  if (b.runtimeType == Exercise) {
                    orderB = (b as Exercise).routineOrder!;
                  } else {
                    orderB = (b as ExerciseContainer).routineOrder!;
                  }
                  return orderA.compareTo(orderB);
                },
              );
            }
            return ListView(children: [
              const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "My Routines",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ...List.generate(
                snapshot.data!.length,
                (index) => RoutineWidget(
                  routine:
                      snapshot.data![index]["routineData"] as ExerciseContainer,
                  exercises: snapshot.data![index]["exercises"] as List<Object>,
                ),
              )
            ]);
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        },
      ),
    );
  }
}
