import 'package:flutter/material.dart';
import 'package:gymmanager/widgets/pages/navdrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      drawer: const NavDrawer(),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "Home Screen",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
