import 'dart:async';

import 'package:flutter/material.dart';

class RoutinePlayProvider extends ChangeNotifier {
  bool timerActive = false;
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

  void initializeTimer(int startingPoint) {
    subscription = Stream<int>.periodic(
      const Duration(seconds: 1),
      (count) {
        return count;
      },
    ).listen((event) {});
    timerActive = true;
    notifyListeners();
  }
}
