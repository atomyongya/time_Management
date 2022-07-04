import "package:flutter/material.dart";
import 'package:time_management_application/utils/colors.dart';
import 'package:time_management_application/widgets/small_text.dart';

class DayCountScreen extends StatefulWidget {
  const DayCountScreen({Key? key}) : super(key: key);

  @override
  State<DayCountScreen> createState() => _DayCountScreen();
}

class _DayCountScreen extends State<DayCountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const SmallTextWidget(text: "Day Count"),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Center(
        child: Column(
          children: const [Text("Count Page")],
        ),
      ),
    );
  }
}
