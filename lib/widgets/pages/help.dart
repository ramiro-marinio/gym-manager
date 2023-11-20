import 'package:flutter/material.dart';
import 'package:gymmanager/widgets/pages/navdrawer.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w900,
    );
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(title: const Text("About Gym Manager")),
      body: PageView(
        children: [
          const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "What is Gym Manager?",
                  style: titleStyle,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Gym manager is an app that allows you to save your routines and statistics, so that you don't have to remember your weights and exercises when you go to the gym. Swipe to the next page to see instructions on how to create a routine!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Step 1: Create exercises in the \"Exercises manager\" section",
                    style: titleStyle,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3)),
                  child: Image.asset("assets/images/create_exercise.png",
                      width: 250),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Step 2: Start creating your routine in the routines section",
                    style: titleStyle,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3)),
                  child: Image.asset(
                    "assets/images/create_routine.png",
                    width: 250,
                  ),
                ),
                const Text(
                  "1: This button will add an exercise.\n2: This button will add a superset, which is a series of exercises that are done one after the other with no rest in between, to save time.\n3:This is the name of your routine.\n4:This is the description.\n5:This is an exercise. Reference A is the reps (or time). Reference B is the sets; reference C is whether the exercise will be dropsetted or not. A dropset means doing the exercise until failure.\n6:This is a superset. The button in reference A adds exercises. Reference B is the sets of your superset.\n7: This button will create your routine.\n\nTo reorder exercises, long tap them and put them where you want them. To delete an exercise or superset, swipe it to the right.",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const Column(
            children: [
              Text(
                "Step 3: Do your routines with the play button!",
                style: titleStyle,
              ),
              Text(
                "You will encounter a widget for each set of your exercises. You can complete these sets with the amount of reps that you did and the weight that you used. This data will then be saved for the next time you need to remember it, and the app will also calculate a recommended weight for you, based on the reps that you do!",
                style: TextStyle(fontSize: 20),
              )
            ],
          )
        ],
      ),
    );
  }
}
