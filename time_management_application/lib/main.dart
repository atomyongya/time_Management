import "package:flutter/material.dart";
import 'package:get/route_manager.dart';
import 'package:time_management_application/login/login.dart';

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
    return const GetMaterialApp(
      title: "Time Management Application",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
