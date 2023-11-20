import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MiniTextField extends StatelessWidget {
  final bool enabled;
  final TextEditingController? controller;
  final Function(String) changeHandler;
  const MiniTextField(
      {super.key,
      this.enabled = true,
      required this.changeHandler,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 40,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          changeHandler(value);
        },
        enabled: enabled,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 0),
        ),
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2),
        ],
      ),
    );
  }
}
