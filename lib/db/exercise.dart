class Exercise {
  int? id;
  final String name;
  final String description;
  final bool repunit;
  Exercise({
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

  Exercise fromJson(Map<String, dynamic> map) => Exercise(
        id: map['id'],
        name: map['Name'],
        description: map['Description'],
        repunit: map['RepUnit'],
      );
}
