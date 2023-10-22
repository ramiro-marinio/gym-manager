class Exercise {
  final int id;
  final int exerciseType;
  int amount;
  int sets;
  int? routineOrder;
  bool dropset;
  bool supersetted;
  int parent;
  Exercise({
    required this.id,
    required this.exerciseType,
    required this.amount,
    required this.sets,
    this.routineOrder,
    required this.dropset,
    required this.supersetted,
    required this.parent,
  });
}
