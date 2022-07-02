import "package:flutter/material.dart";
import 'package:time_management_application/utils/colors.dart';
import 'package:time_management_application/widgets/small_text.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  State<TimeTableScreen> createState() => _TimeTableScreen();
}

class _TimeTableScreen extends State<TimeTableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const SmallTextWidget(text: "Time Table"),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
