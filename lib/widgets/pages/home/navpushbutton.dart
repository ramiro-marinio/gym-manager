import 'package:flutter/material.dart';

class NavPushButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final Widget address;
  const NavPushButton(
      {super.key,
      required this.address,
      required this.text,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => address,
          ),
        ),
        icon: icon,
        label: Text(text),
      ),
    );
  }
}
