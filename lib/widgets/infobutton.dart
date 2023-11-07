import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  final String title;
  final String text;
  final Widget icon;
  const InfoButton(
      {super.key, required this.title, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashRadius: 20,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        },
        icon: icon);
  }
}
