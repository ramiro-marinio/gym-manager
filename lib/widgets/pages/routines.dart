import 'package:flutter/material.dart';
import 'package:gymmanager/providers/db/dbprovider.dart';
import 'package:gymmanager/providers/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/db/resources/routinewidget.dart';
import 'package:gymmanager/widgets/navdrawer.dart';
import 'package:gymmanager/widgets/pages/forms/create_routine.dart';
import 'package:provider/provider.dart';

class Routines extends StatefulWidget {
  const Routines({super.key});

  @override
  State<Routines> createState() => _RoutinesState();
}

class _RoutinesState extends State<Routines> {
  @override
  Widget build(BuildContext context) {
    Future<List<ExerciseContainer>> routines =
        context.watch<DbProvider>().getRoutines();
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
            return ListView(children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "My Routines",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
              ...List.generate(
                snapshot.data!.length,
                (index) => RoutineWidget(
                  routine: snapshot.data![index],
                  exercises: const [],
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
