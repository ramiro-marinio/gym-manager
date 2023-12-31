import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercise_recording/setrecord.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:gymmanager/functions/avg.dart';
import 'package:gymmanager/functions/recommended_weight.dart';
import 'package:gymmanager/functions/weightunit.dart';
import 'package:gymmanager/providers/dbprovider.dart';
import 'package:provider/provider.dart';

class StatsView extends StatefulWidget {
  final Exercise exercise;
  const StatsView({super.key, required this.exercise});

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  final TextStyle style = const TextStyle(
    fontSize: 25,
  );
  @override
  Widget build(BuildContext context) {
    DbProvider dbProvider = context.read<DbProvider>();
    ExerciseType exerciseType = widget.exercise.exerciseType;
    Future<Map<String, dynamic>?> stats =
        dbProvider.getStatisticsOf(exerciseType);
    return StatefulBuilder(
      builder: (context, setState) {
        return Visibility(
          visible: widget.exercise.exerciseType.repunit,
          child: FutureBuilder<Map<String, dynamic>?>(
            future: stats,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  return const Card(
                    color: Color.fromARGB(255, 130, 0, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 125,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Expanded(
                              child: AutoSizeText(
                                "Statistics: Not enough statistics!",
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "They will show up after this exercise is done at least once.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                print(snapshot.data!['lowestWeight']);
                bool kgUnit = snapshot.data!['kgUnit'];
                List<SetRecord> lastWeights = snapshot.data!['lastWeights'];

                List<double> recommendedWeights = List.generate(
                  lastWeights.length,
                  (index) => recommendedWeight(
                      weight: lastWeights[index].weight,
                      reps: lastWeights[index].amount,
                      desidedReps: widget.exercise.amount),
                );
                return Card(
                  color: const Color.fromARGB(255, 100, 130, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        AutoSizeText(
                          "Weight Statistics of \"${exerciseType.name}\"",
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w900),
                        ),
                        AutoSizeText(
                          "Last weight:${weightUnit(lastWeights[0].weight, kgUnit).toStringAsFixed(2)} ${kgUnit ? "kg" : "lb"}",
                          maxLines: 1,
                          style: style,
                        ),
                        AutoSizeText(
                          "Highest weight:${weightUnit(snapshot.data!['highestWeight'], kgUnit).toStringAsFixed(2)} ${kgUnit ? "kg" : "lb"}",
                          maxLines: 1,
                          style: style,
                        ),
                        AutoSizeText(
                          "Lowest Weight:${weightUnit(snapshot.data!['lowestWeight'], kgUnit).toStringAsFixed(2)} ${kgUnit ? "kg" : "lb"}",
                          maxLines: 1,
                          style: style,
                        ),
                        AutoSizeText(
                          "Recommended weight:${weightUnit(average(recommendedWeights), kgUnit).toStringAsFixed(2)} ${kgUnit ? "kg" : "lb"}",
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator.adaptive();
              }
            },
          ),
        );
      },
    );
  }
}
