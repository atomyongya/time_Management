import "package:flutter/material.dart";
import 'package:time_management_application/utils/colors.dart';
import 'package:time_management_application/widgets/small_text.dart';

class NotifyScreen extends StatefulWidget {
  const NotifyScreen({Key? key}) : super(key: key);

  @override
  State<NotifyScreen> createState() => _NotifyScreen();
}

class _NotifyScreen extends State<NotifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const SmallTextWidget(text: "Notify"),
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
