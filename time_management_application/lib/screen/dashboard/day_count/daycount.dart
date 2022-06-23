import "package:flutter/material.dart";

class DayCountScreen extends StatefulWidget {
  const DayCountScreen({Key? key}) : super(key: key);

  @override
  State<DayCountScreen> createState() => _DayCountScreen();
}

class _DayCountScreen extends State<DayCountScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Day Count Page"),
    );
  }
}
