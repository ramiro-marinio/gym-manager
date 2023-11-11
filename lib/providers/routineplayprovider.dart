import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/widgets/routines/stats/recorder.dart';

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
    ).listen((event) {
      time = event;
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
  }

  void start(ExerciseContainer? routine) {
    currentRoutine = routine;
    currentExercise = 0;
    time = 0;
    timerActive = false;
    notifyListeners();
  }

  void endRoutine() {}
}
