import 'package:flutter/material.dart';
import 'package:gymmanager/providers/dbprovider.dart';
import 'package:gymmanager/widgets/pages/home/linkbutton.dart';
import 'package:gymmanager/widgets/pages/home/navpushbutton.dart';
import 'package:gymmanager/widgets/pages/navdrawer.dart';
import 'package:gymmanager/widgets/routine_creation/forms/create_routine.dart';
import 'package:gymmanager/widgets/routine_creation/forms/exercises/create_exercise.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<DbProvider>().database.then((value) => null);
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      drawer: const NavDrawer(),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "Welcome to Gym Manager",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          Text(
            "Shortcuts",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          LinkButton(
            address: "/exercises",
            text: "MANAGE EXERCISES",
            icon: Icon(Icons.fitness_center),
          ),
          LinkButton(
            address: "/routines",
            text: "MANAGE ROUTINES",
            icon: Icon(Icons.list),
          ),
          LinkButton(
            address: "/user_settings",
            text: "SETTINGS",
            icon: Icon(Icons.settings),
          ),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          Text(
            "Create...",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          NavPushButton(
            address: CreateExercise(modifyMode: false),
            text: "AN EXERCISE",
            icon: Icon(Icons.fitness_center),
          ),
          NavPushButton(
            address: CreateRoutine(),
            text: "A ROUTINE",
            icon: Icon(Icons.list),
          ),
        ],
      ),
    );
  }
}
