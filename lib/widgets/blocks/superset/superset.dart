import 'package:flutter/material.dart';
import 'package:gymmanager/db/dbprovider.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:gymmanager/widgets/blocks/superset/miniexercisewidget.dart';
import 'package:gymmanager/widgets/pages/forms/exercises/add_exercise.dart';
import 'package:provider/provider.dart';

class SuperSet extends StatefulWidget {
  const SuperSet({super.key});

  @override
  State<SuperSet> createState() => _SuperSetState();
}

class _SuperSetState extends State<SuperSet> {
  final List<MiniExerciseWidget> _superset = [];
  @override
  Widget build(BuildContext context) {
    List<ExerciseType> exerciseList = context.watch<DbProvider>().exercises;
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      direction: DismissDirection.endToStart,
      key: Key(UniqueKey().toString()),
      child: Card(
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
