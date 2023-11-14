import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LinkButton extends StatelessWidget {
  final String address;
  final String text;
  final Widget icon;
  const LinkButton(
      {super.key,
      required this.address,
      required this.text,
      required this.icon});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ElevatedButton.icon(
        icon: icon,
        onPressed: () {
          context.go(address);
        },
        label: Text(text),
      ),
    );
  }
}
