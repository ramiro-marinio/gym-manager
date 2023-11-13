import 'package:flutter/material.dart';
import 'package:gymmanager/db/functions/generateexercises.dart';
import 'package:gymmanager/db/functions/generateroutine.dart';
import 'package:gymmanager/db/functions/generatesupersets.dart';
import 'package:gymmanager/db/resources/exercise.dart';
import 'package:gymmanager/db/resources/exercise_recording/setrecord.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';
import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:gymmanager/settings/settings.dart';
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
      version: 5,
      onCreate: (db, version) async {
        String sql = await rootBundle.loadString("assets/oncreate.sql");
        List<String> statements = sql.split(';');
        for (String statement in statements) {
          if (statement.trim().isNotEmpty) {
            await db.execute(statement);
          }
        }
      },
      onOpen: (db) async {
        //This is necessary for foreign keys to work
        await db.execute("PRAGMA foreign_keys = ON;");
      },
    );
  }

  //EXERCISES SECTION
  List<ExerciseType>? _exerciseTypes;
  Future<void> init() async {
    Database db = await database;
    List<Map<String, dynamic>> data =
        await db.query('ExerciseTypes', orderBy: "Name ASC");
    _exerciseTypes = [];
    for (Map exercise in data) {
      _exerciseTypes!.add(
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
    if (_exerciseTypes == null) {
      init();
      return [];
    }
    return _exerciseTypes!;
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
    for (var i = 0; i < _exerciseTypes!.length; i++) {
      if (_exerciseTypes![i].id == id) {
        _exerciseTypes!.removeAt(i);
        notifyListeners();
        break;
      }
    }
    db.delete('Exercises', where: 'ExerciseType=$id');
  }

  //END OF EXERCISES SECTION
  //ROUTINE SECTION
  Future<int> createRoutine(ExerciseContainer routine) async {
    Database db = await database;
    int id = await db.insert('ExerciseContainers', routine.toJson());
    notifyListeners();
    return id;
  }

  Future<void> deleteExerciseContainer(int id) async {
    Database db = await database;
    db.delete("ExerciseContainers", where: "Id=$id OR Parent=$id");
    db.delete("RoutineRecords");
    db.delete("Exercises", where: "Parent=$id");
    notifyListeners();
  }

  Future<int> createSuperset(ExerciseContainer superset) async {
    Database db = await database;
    int id = await db.insert('ExerciseContainers', superset.toJson());
    return id;
  }

  Future<int> createRoutineExercise(Exercise exercise) async {
    Database db = await database;
    int id = await db.insert('Exercises', exercise.toJson());
    return id;
  }

  Future<void> deleteRoutineExercise(int id) async {
    Database db = await database;
    db.delete("Exercises", where: "Id=$id");
    db.delete("SetRecords", where: "ExerciseId=$id");
  }

  Future<List<Map<String, Object>>> getRoutines() async {
    Database db = await database;
    List<Map<String, Object>> result = [];
    List<Map<String, Object?>> routineMaps =
        await db.query('ExerciseContainers', where: "IsRoutine=1");
    for (var i = 0; i < routineMaps.length; i++) {
      Map<String, Object?> map = routineMaps[i];
      List<Exercise> exercises = await generateExercises(
          db, await db.query("Exercises", where: "Parent=${map["Id"]}"));
      List<ExerciseContainer> exerciseContainerMaps = await generateSupersets(
          await db.query("ExerciseContainers",
              where: "IsRoutine=0 AND Parent=${map["Id"]}"),
          db);
      result.add({
        'routineData': generateRoutine(map),
        'exercises': [...exercises, ...exerciseContainerMaps]
      });
    }
    return result;
  }

  //END OF ROUTINE SECTION
  //START OF STATISTICS SECTION
  void createSetRecords(List<SetRecord> setRecords) async {
    Database db = await database;
    for (SetRecord record in setRecords) {
      db.insert('SetRecords', record.toJson());
    }
  }

  void createRoutineRecord(Map<String, dynamic> map) async {
    Database db = await database;
    db.insert('RoutineRecords', map);
  }

  Future<SetRecord> getRecordByWeight(
      ExerciseType exerciseType, bool highestWeight) async {
    Database db = await database;
    Map<String, Object?> map = (await db.query('SetRecords',
        where: "ExerciseType=${exerciseType.id}",
        orderBy: 'Weight ${'ASC'}',
        limit: 1))[0];
    return SetRecord(
      id: map['Id'] as int,
      exerciseType: exerciseType,
      amount: map['Amount'] as int,
      weight: map['Weight'] as double,
    );
  }

  Future<List<SetRecord>> getLastRecords(
      ExerciseType exerciseType, int limit) async {
    Database db = await database;
    List<Map<String, Object?>> maps = (await db.query('SetRecords',
        where: "ExerciseType=${exerciseType.id}",
        orderBy: 'CreationDate DESC',
        limit: limit));
    return List.generate(maps.length, (index) {
      Map<String, Object?> map = maps[index];
      return SetRecord(
        id: map['Id'] as int,
        exerciseType: exerciseType,
        amount: map['Amount'] as int,
        weight: map['Weight'] as double,
      );
    });
  }

  Future<Map<String, dynamic>?> getStatisticsOf(
      ExerciseType exerciseType) async {
    List<SetRecord> lastWeights = (await getLastRecords(exerciseType, 12));
    try {
      return {
        'highestWeight':
            (await getRecordByWeight(exerciseType, true)).amount.toDouble(),
        'lowestWeight':
            (await getRecordByWeight(exerciseType, false)).amount.toDouble(),
        'lastWeights': lastWeights,
        'kgUnit': await Settings().getUnit(),
      };
    } on Exception catch (_) {
      return null;
    }
  }
  //END OF STATISTICS SECTION
}
