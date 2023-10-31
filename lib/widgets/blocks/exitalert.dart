import 'package:flutter/material.dart';

class ExitAlert extends StatelessWidget {
  const ExitAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Leave?"),
      content: const Text(
          "You are still building the routine. If you leave, it will not be saved. Proceed anyway?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
