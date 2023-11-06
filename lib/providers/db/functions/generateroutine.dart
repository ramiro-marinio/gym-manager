import 'package:gymmanager/providers/db/resources/exercisecontainer.dart';

ExerciseContainer generateRoutine(Map<String, Object?> map) {
  return ExerciseContainer(
    isRoutine: true,
    creationDate: map["CreationDate"] as String,
    name: map["Name"] as String,
    description: map["Description"] as String,
    id: map["Id"] as int,
  );
}
