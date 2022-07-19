import "package:flutter/material.dart";
import 'package:time_management_application/screen/dashboard/day_count/Components/add_day_count.dart';
import 'package:time_management_application/utils/colors.dart';
import 'package:time_management_application/widgets/customize_icon.dart';
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
      appBar: AppBar(
        title: const SmallTextWidget(text: "Day Count"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: const [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddDayCount(),
          );
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(
          Icons.add,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
