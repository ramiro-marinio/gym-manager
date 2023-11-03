//ExerciseContainer can either be a routine or a superset.
//Even though it is unintuitive, it's the best way to do it if you have to use sqlite.
import 'package:gymmanager/widgets/blocks/exercise_widget.dart';

class ExerciseContainer {
  final int? id;
  String? name;
  String? description;
  List<ExerciseWidget>? children;
  bool isRoutine;
  //sets, parent and routineOrder will only have a value if "isRoutine" is false. creationDate will only have a a value if "isRoutine" is true.
  DateTime? creationDate;
  int? routineOrder;
  int? parent;
  int? sets;
  ExerciseContainer({
    required this.isRoutine,
    this.id,
    this.name,
    this.description,
    this.creationDate,
    this.parent,
    this.sets,
    this.routineOrder,
    this.children,
  });
  Map<String, dynamic> toJson() {
    return id != null
        ? {
            'Id': id,
            'Name': name,
            'Description': description,
            'isRoutine': isRoutine,
            'CreationDate': creationDate,
            'RoutineOrder': routineOrder,
            'Parent': parent,
            'Sets': sets,
          }
        : {
            'Name': name,
            'Description': description,
            'isRoutine': isRoutine,
            'CreationDate': creationDate,
            'RoutineOrder': routineOrder,
            'Parent': parent,
            'Sets': sets,
          };
  }
}
