import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;

class DbProvider extends ChangeNotifier {
  Future<String> get dbdir async {
    return getDatabasesPath();
  }

  Future<Database> get database async {
    String dbpath = '${await dbdir}gymmanager.db';
    return await openDatabase(
      dbpath,
      version: 1,
      onCreate: (db, version) async {
        String sql = await rootBundle.loadString("assets/oncreate.sql");
        List<String> statements = sql.split(';');
        for (String statement in statements) {
          if (statement.trim().isNotEmpty) {
            await db.execute(statement);
          }
        }
      },
      // onOpen: (db) {
      //   deleteDatabase(dbpath);
      // },
    );
  }

  //EXERCISES SECTION
  List<ExerciseType>? _exercises;
  Future<void> init() async {
    Database db = await database;
    List<Map<String, dynamic>> data =
        await db.query('ExerciseTypes', orderBy: "Name ASC");
    _exercises = [];
    for (Map exercise in data) {
      _exercises!.add(
        ExerciseType(
          id: exercise['Id'],
          name: exercise['Name'],
          description: exercise['Description'],
          repunit: exercise['RepUnit'] == 1 ? true : false,
        ),
      );
    }
    notifyListeners();
  }

  List<ExerciseType> get exercises {
    if (_exercises == null) {
      init();
      return [];
    }
    return _exercises!;
  }

  Future<void> createExercise(ExerciseType exercise) async {
    Database db = await database;
    db.insert(
      'ExerciseTypes',
      exercise.toJson(),
    );
    init();
    notifyListeners();
  }

  Future<void> modifyExercise(ExerciseType exercise) async {
    Database db = await database;
    db.update(
      'ExerciseTypes',
      exercise.toJson(),
      where: 'Id=${exercise.id}',
    );
    init();
  }

  Future<void> deleteExercise(int id) async {
    Database db = await database;
    db.delete('ExerciseTypes', where: 'Id=$id');
    for (var i = 0; i < _exercises!.length; i++) {
      if (_exercises![i].id == id) {
        _exercises!.removeAt(i);
        notifyListeners();
        break;
      }
    }
  }
  //END OF EXERCISES SECTION
}
