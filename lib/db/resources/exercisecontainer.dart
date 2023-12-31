//ExerciseContainer can either be a routine or a superset.
//Even though it is unintuitive, it's the best way to do it if you have to use sqlite.
import 'package:gymmanager/widgets/routine_creation/widgets/exercise_widget.dart';

class ExerciseContainer {
  final int? id;
  String? name;
  String? description;
  List<ExerciseWidget>? children;
  bool isRoutine;
  //sets, parent and routineOrder will only have a value if "isRoutine" is false. creationDate will only have a a value if "isRoutine" is true.
  String? creationDate;
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
            'isRoutine': isRoutine ? 1 : 0,
            'CreationDate': creationDate,
            'RoutineOrder': routineOrder,
            'Parent': parent,
            'Sets': sets != 0 ? sets : 3,
          }
        : {
            'Name': name,
            'Description': description,
            'isRoutine': isRoutine ? 1 : 0,
            'CreationDate': creationDate,
            'RoutineOrder': routineOrder,
            'Parent': parent,
            'Sets': sets != 0 ? sets : 3,
          };
  }
}
