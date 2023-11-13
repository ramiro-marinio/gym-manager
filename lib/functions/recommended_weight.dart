import 'dart:math';

//this function is based on statistics and approximates the percentage of weight compared to the one rep max so that you can do a certain amount of reps.
//It is very approximate, but it works
double _maxRepsPctg(int reps) {
  return 0.9694 * exp(-0.022 * reps);
}

double recommendedWeight({
  required double weight,
  required int reps,
  required int desidedReps,
}) {
  double oneRepMax = weight / _maxRepsPctg(reps);
  return _maxRepsPctg(desidedReps) * oneRepMax;
}
