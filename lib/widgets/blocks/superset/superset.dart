import 'package:flutter/material.dart';
import 'package:gymmanager/providers/db/dbprovider.dart';
import 'package:gymmanager/providers/db/resources/exercise.dart';
import 'package:gymmanager/providers/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/db/resources/exercisetype.dart';
import 'package:gymmanager/widgets/blocks/exercise_widget.dart';
import 'package:gymmanager/widgets/pages/forms/exercises/add_exercise.dart';
import 'package:provider/provider.dart';

class SuperSet extends StatefulWidget {
  final ExerciseContainer superset;
  const SuperSet({
    super.key,
    required this.superset,
    /*this.children*/
  });

  @override
  State<SuperSet> createState() => _SuperSetState();
}

class _SuperSetState extends State<SuperSet> {
  @override
  Widget build(BuildContext context) {
    List<ExerciseType> exerciseList = context.watch<DbProvider>().exercises;
    ExerciseContainer superset = widget.superset;

    void delete(int index) {
      setState(() {
        superset.children!.removeAt(index);
      });
    }

    return Card(
      color: const Color.fromARGB(255, 150, 150, 255),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: superset.children!,
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final ExerciseWidget item =
                    superset.children!.removeAt(oldIndex);
                superset.children!.insert(newIndex, item);
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
                                Exercise e = Exercise(
                                    amount: 1,
                                    sets: 1,
                                    dropset: false,
                                    exerciseType: exerciseType,
                                    supersetted: true);
                                superset.children!.add(
                                  ExerciseWidget(
                                    key: key,
                                    exercise: e,
                                    mini: true,
                                    dropsetSwitch: () {
                                      e.dropset = !e.dropset;
                                    },
                                    onDelete: () {
                                      int index = 0;
                                      for (ExerciseWidget exercise
                                          in superset.children!) {
                                        if (exercise.key == key) {
                                          delete(index);
                                          break;
                                        }
                                        index++;
                                      }
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
                Card(
                  color: const Color.fromARGB(255, 113, 113, 191),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sets: ${widget.superset.sets}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (widget.superset.sets != null) {
                            setState(() {
                              widget.superset.sets = widget.superset.sets! + 1;
                            });
                          }
                        },
                        icon: const Icon(Icons.add),
                        iconSize: 25,
                        splashRadius: 12.5,
                      ),
                      IconButton(
                        onPressed: () {
                          if (widget.superset.sets != null) {
                            if (widget.superset.sets! > 1) {
                              setState(() {
                                widget.superset.sets =
                                    widget.superset.sets! - 1;
                              });
                            }
                          }
                        },
                        icon: const Icon(Icons.remove),
                        iconSize: 25,
                        splashRadius: 12.5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
