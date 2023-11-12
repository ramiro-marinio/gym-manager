import 'package:gymmanager/db/resources/exercisetype.dart';
import 'package:intl/intl.dart';

class SetRecord {
  final int? id;
  final ExerciseType exerciseType;
  int amount;
  int weight;
  SetRecord({
    this.id,
    required this.exerciseType,
    required this.amount,
    required this.weight,
  });
  Map<String, dynamic> toJson() {
    DateTime datetime = DateTime.now();
    Map<String, dynamic> map = {
      'ExerciseType': exerciseType.id!,
      'CreationDate': DateFormat("yyyy-MM-dd HH:mm:ss").format(datetime),
      'Amount': amount,
      'Weight': weight,
    };
    if (id != null) {
      map['Id'] = id;
    }
    return map;
  }
}
