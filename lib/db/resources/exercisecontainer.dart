class ExerciseContainer {
  final int? id;
  String? name;
  String? description;
  DateTime? creationDate;
  bool isRoutine;
  int? parent;
  //sets will only have a value if "isRoutine" is false.
  int? sets;
  ExerciseContainer({
    required this.isRoutine,
    this.id,
    this.name,
    this.description,
    this.creationDate,
    this.parent,
    this.sets,
  });
}
