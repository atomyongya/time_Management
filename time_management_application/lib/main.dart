import "package:flutter/material.dart";
import 'package:time_management_application/utils/navigator.dart';

void main() {
  runApp(const TimeManagement());
}

class TimeManagement extends StatefulWidget {
  const TimeManagement({Key? key}) : super(key: key);

  @override
  State<TimeManagement> createState() => _TimeManagement();
}

class _TimeManagement extends State<TimeManagement> {
  @override
  Widget build(BuildContext context) {
    return const NavigatorWidget();
  }
}
