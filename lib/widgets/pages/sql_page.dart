import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymmanager/providers/dbprovider.dart';
import 'package:gymmanager/widgets/infobutton.dart';
import 'package:gymmanager/widgets/navdrawer.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class SqlPage extends StatefulWidget {
  const SqlPage({super.key});

  @override
  State<SqlPage> createState() => _SqlPageState();
}

class _SqlPageState extends State<SqlPage> {
  @override
  Widget build(BuildContext context) {
    DbProvider provider = context.read<DbProvider>();
    TextEditingController cmdController = TextEditingController();
    final scarySound = AudioPlayer();
    scarySound.setAsset("assets/scary.mp3");
    scarySound.setVolume(100);
    scarySound.load();
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text("SQL Page"),
        actions: const [
          InfoButton(
              title: "WARNING!",
              text:
                  "This page is only present for debugging purposes. If you somehow managed to get access, DO NOT DO ANYTHING. It could permanently damage your data, such as your routines and statistics.",
              icon: Icon(Icons.warning))
        ],
      ),
      body: Column(
        children: [
          const Text(
            "SQL PAGE",
            style: TextStyle(fontSize: 30),
          ),
          TextField(
            controller: cmdController,
            decoration: const InputDecoration(hintText: "Command"),
          ),
          ElevatedButton(
            onPressed: () async {
              Database database = await provider.database;
              try {
                database.execute(cmdController.text);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Successful"),
                    ),
                  );
                }
              } on Exception catch (_, e) {
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("error"),
                      content: Text(e.toString()),
                    ),
                  );
                }
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromARGB(255, 150, 0, 0)),
            ),
            child: const Text("Raw Execution"),
          ),
          ElevatedButton(
            onPressed: () async {
              Database database = await provider.database;
              try {
                List<Map> list = await database.rawQuery(cmdController.text);
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Success"),
                      content:
                          SingleChildScrollView(child: Text(list.toString())),
                    ),
                  );
                }
              } on Exception catch (e) {
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content:
                            SingleChildScrollView(child: Text(e.toString())),
                      );
                    },
                  );
                }
              }
            },
            child: const Text("Raw Query"),
          ),
          ElevatedButton(
            onPressed: () async {
              deleteDatabase("${await provider.dbdir}gymmanager.db");
              if (context.mounted) {
                scarySound.play();
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text("Done"),
                    content:
                        Text("Database was wiped out. The app will now close."),
                  ),
                );
                Future.delayed(
                  const Duration(seconds: 8),
                  () => exit(0),
                );
              }
            },
            child: const Text("WIPE OUT DATABASE"),
          ),
        ],
      ),
    );
  }
}
