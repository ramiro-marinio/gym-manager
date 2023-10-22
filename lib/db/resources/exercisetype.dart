class ExerciseType {
  int? id;
  final String name;
  final String description;
  final bool repunit;
  ExerciseType({
    this.id,
    required this.name,
    required this.description,
    required this.repunit,
  });

  Map<String, dynamic> toJson() {
    return id != null
        ? {
            'Id': id,
            'Name': name,
            'Description': description,
            'RepUnit': repunit ? 1 : 0,
          }
        : {
            'Name': name,
            'Description': description,
            'RepUnit': repunit ? 1 : 0,
          };
  }

  ExerciseType fromJson(Map<String, dynamic> map) => ExerciseType(
        id: map['id'],
        name: map['Name'],
        description: map['Description'],
        repunit: map['RepUnit'],
      );
}
