import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymmanager/settings/settings.dart';
import 'package:gymmanager/widgets/pages/navdrawer.dart';
import 'package:sqflite/sqflite.dart';

class SettingsPage extends StatefulWidget {
  final Future<bool> kgUnit = Settings().getUnit();
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool switchValue = false;
  bool? settingsValue;
  @override
  Widget build(BuildContext context) {
    widget.kgUnit.whenComplete(
      () => widget.kgUnit.then(
        (value) {
          setState(() {
            settingsValue ??= value;
          });
        },
      ),
    );
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Settings",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
          ),
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Unit:",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Switch(
              value: switchValue,
              onChanged: (value) {
                setState(() {
                  switchValue = !switchValue;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                switchValue ? "kg" : "lb",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: switchValue != settingsValue
                  ? () {
                      Settings().setUnit(switchValue);
                      setState(
                        () {
                          settingsValue = switchValue;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                              Text("Updated Successfully!"),
                            ],
                          )));
                        },
                      );
                    }
                  : null,
              child: const Text("Save"),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 8),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("WARNING!"),
                      content: const Text(
                          "This will permanently delete all of your exercises, routines and statistics. You should only do this because of a critical reason, such as your database being corrupted. Proceed?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("NO"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: Colors.black,
                              builder: (context) => AlertDialog(
                                title: const Text("Done."),
                                content: const Text(
                                    "The database will delete after pressing the OK button. However, if you regret your decision, you can close the app and the database will not delete."),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      deleteDatabase(
                                        "${await getDatabasesPath()}gymmanager.db",
                                      );
                                      exit(0);
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text("YES"),
                        ),
                      ],
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromARGB(255, 109, 30, 25),
                  ),
                ),
                child: const Text("Reset Database"),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
