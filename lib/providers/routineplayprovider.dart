import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';

class RoutinePlayProvider extends ChangeNotifier {
  bool timerActive = false;
  int time = 0;
  int currentExercise = 0;
  ExerciseContainer? currentRoutine;
  StreamSubscription<int>? subscription;
  void toggleTimer() {
    if (timerActive) {
      subscription?.pause();
    } else {
      subscription?.resume();
    }
    timerActive = !timerActive;
    notifyListeners();
  }

  void initializeTimer(int startingPoint, ExerciseContainer routine) {
    currentRoutine = routine;
    subscription = Stream<int>.periodic(
      const Duration(seconds: 1),
      (count) {
        return count;
      },
    ).listen((event) {
      time = event;
      notifyListeners();
    });
    timerActive = true;
    notifyListeners();
  }

  void stop() {
    subscription?.cancel();
    subscription = null;
    time = 0;
    timerActive = false;
    currentExercise = 0;
    currentRoutine = null;
  }

  void init(ExerciseContainer routine) {
    currentRoutine = routine;
    currentExercise = 0;
    time = 0;
    timerActive = false;
    notifyListeners();
  }
}
