import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/providers/routinecreationprovider.dart';
import 'package:gymmanager/widgets/routine_creation/widgets/exercise_widget.dart';
import 'package:gymmanager/widgets/routine_creation/forms/exercises/add_exercise.dart';
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
    late ExerciseContainer superset;
    CreationProvider creationProvider = Provider.of<CreationProvider>(context);
    for (var i = 0; i < creationProvider.routine.length; i++) {
      if (creationProvider.routine[i].child.runtimeType == SuperSet) {
        superset = (creationProvider.routine[i].child as SuperSet).superset;
      }
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
                                amount: exerciseType.repunit ? 12 : 300,
                                sets: 1,
                                dropset: false,
                                exerciseType: exerciseType,
                                supersetted: true,
                              );
                              superset.children!.add(
                                ExerciseWidget(
                                  superset: widget.superset,
                                  key: key,
                                  exercise: e,
                                  supersetMode: true,
                                  dropsetSwitch: () {
                                    e.dropset = !e.dropset;
                                  },
                                  setState: setState,
                                ),
                              );
                            });
                          },
                        ),
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
