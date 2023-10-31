import 'package:flutter/material.dart';
import 'package:gymmanager/db/dbprovider.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:gymmanager/widgets/blocks/superset/miniexercisewidget.dart';
import 'package:gymmanager/widgets/pages/forms/exercises/add_exercise.dart';
import 'package:provider/provider.dart';

class SuperSet extends StatefulWidget {
  final List<MiniExerciseWidget>? exercises;
  final ExerciseContainer superset;
  const SuperSet({super.key, required this.superset, this.exercises});

  @override
  State<SuperSet> createState() => _SuperSetState();
}

class _SuperSetState extends State<SuperSet> {
  final List<MiniExerciseWidget> _superset = [];
  @override
  Widget build(BuildContext context) {
    List<ExerciseType> exerciseList = context.watch<DbProvider>().exercises;
    return Card(
      color: const Color.fromARGB(255, 150, 150, 255),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: _superset,
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final MiniExerciseWidget item = _superset.removeAt(oldIndex);
                _superset.insert(newIndex, item);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddExercise(
                            onChoose: (exerciseType) {
                              setState(() {
                                Key key = UniqueKey();
                                _superset.add(
                                  MiniExerciseWidget(
                                    exerciseType: exerciseType,
                                    key: key,
                                    onDelete: () {
                                      setState(() {
                                        int index = 0;
                                        for (MiniExerciseWidget exercise
                                            in _superset) {
                                          if (exercise.key == key) {
                                            _superset.removeAt(index);
                                            break;
                                          }
                                          index++;
                                        }
                                      });
                                    },
                                  ),
                                );
                              });
                            },
                            exercises: exerciseList),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  splashRadius: 25,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
