import 'package:flutter/material.dart';

class MiniTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  const MiniTextField(
      {super.key, required this.controller, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 20,
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 0),
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}
