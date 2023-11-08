import 'package:flutter/material.dart';

class TimeSetter extends StatefulWidget {
  final Function(int) setTime;
  const TimeSetter({super.key, required this.setTime});

  @override
  State<TimeSetter> createState() => _TimeSetterState();
}

class _TimeSetterState extends State<TimeSetter> {
  int minutes = 0;
  int seconds = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Set time"),
      content: SingleChildScrollView(
        child: Center(
          child: ListBody(
            children: [
              Row(
                children: [
                  const Text("Minutes:"),
                  SizedBox(
                    width: 180,
                    child: Slider(
                      value: minutes.toDouble(),
                      max: 59,
                      activeColor: Color.fromARGB(
                          255,
                          (255 / 59 * minutes).toInt(),
                          0,
                          255 - (255 / 59 * minutes).toInt()),
                      onChanged: (value) {
                        setState(() {
                          minutes = value.toInt();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                      width: 20,
                      child: Text(
                        minutes.toString(),
                        maxLines: 1,
                      )),
                ],
              ),
              Row(
                children: [
                  const Text("Secs:"),
                  SizedBox(
                    width: 180,
                    child: Slider(
                      value: seconds.toDouble(),
                      max: 59,
                      activeColor: Color.fromARGB(
                          255,
                          (255 / 59 * seconds).toInt(),
                          0,
                          255 - (255 / 59 * seconds).toInt()),
                      onChanged: (value) {
                        setState(() {
                          seconds = value.toInt();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                      width: 20,
                      child: Text(
                        seconds.toString(),
                        maxLines: 1,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL")),
        TextButton(
            onPressed: () {
              widget.setTime(minutes * 60 + seconds);
              Navigator.pop(context);
            },
            child: const Text("SET"))
      ],
    );
  }
}
