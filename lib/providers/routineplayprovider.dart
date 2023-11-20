import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/dbprovider.dart';
import 'package:gymmanager/widgets/routine_usage/stats/recorder.dart';
import 'package:intl/intl.dart';

class RoutinePlayProvider extends ChangeNotifier {
  bool timerActive = false;
  int time = 0;
  int currentExercise = 0;
  ExerciseContainer? currentRoutine;
  StreamSubscription<int>? _subscription;
  StreamSubscription<int>? get subscription {
    return _subscription;
  }

  List<Recorder> recorderPages = [];

  void toggleTimer() {
    if (timerActive) {
      _subscription?.pause();
    } else {
      _subscription?.resume();
    }
    timerActive = !timerActive;
    notifyListeners();
  }

  void initializeTimer(int startingPoint, ExerciseContainer routine) {
    currentRoutine = routine;
    _subscription = Stream<int>.periodic(
      const Duration(seconds: 1),
      (count) {
        return count;
      },
    ).listen((seconds) {
      time = seconds + 1;
      notifyListeners();
    });
    timerActive = true;
    notifyListeners();
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
    time = 0;
    timerActive = false;
    currentExercise = 0;
    currentRoutine = null;
    recorderPages.clear();
    notifyListeners();
  }

  void start(ExerciseContainer? routine) {
    stop();
    currentRoutine = routine;
    currentExercise = 0;
    time = 0;
    timerActive = false;
    notifyListeners();
  }

  void endRoutine(
      {required DbProvider dbProvider,
      required BuildContext context,
      required bool kgUnit}) {
    dbProvider.createRoutineRecord({
      'RoutineId': currentRoutine!.id,
      'RoutineTime': time,
      'Moment': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    });
    for (var i = 0; i < recorderPages.length; i++) {
      dbProvider.createSetRecords(recorderPages[i].getRecords(), kgUnit);
    }
    stop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            Text("Routine Complete!"),
          ],
        ),
      ),
    );
    Navigator.pop(context);
  }
}
