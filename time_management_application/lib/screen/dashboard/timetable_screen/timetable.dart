import "package:flutter/material.dart";

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  State<TimeTableScreen> createState() => _TimeTableScreen();
}

class _TimeTableScreen extends State<TimeTableScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Time Table Page"),
    );
  }
}
