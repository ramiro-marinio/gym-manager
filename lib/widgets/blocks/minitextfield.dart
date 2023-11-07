import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MiniTextField extends StatelessWidget {
  final bool enabled;
  final Function(String) changeHandler;
  const MiniTextField(
      {super.key, this.enabled = true, required this.changeHandler});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 20,
      child: TextField(
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
