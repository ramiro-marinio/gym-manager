import 'package:flutter/material.dart';
import 'package:gymmanager/db/resources/exercisecontainer.dart';

class SupersetSet extends StatefulWidget {
  final ExerciseContainer superset;
  const SupersetSet({super.key, required this.superset});

  @override
  State<SupersetSet> createState() => _SupersetSetState();
}

class _SupersetSetState extends State<SupersetSet> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
