import "package:flutter/material.dart";
import 'package:time_management_application/screen/dashboard/notify_screen/add_list.dart';
import 'package:time_management_application/utils/colors.dart';
import 'package:time_management_application/widgets/big_text.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              // Title for event
              eventDateTime(
                "Event",
                "Date",
                "Time",
                topLeft: 10,
                topRight: 10,
              ),
              const SizedBox(height: 15),

              // List of event
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, valueIndex) {
                    return Column(
                      children: [
                        eventDateTime(
                          "event",
                          "date",
                          "time",
                          color: Colors.lightBlueAccent,
                          fontSize: 13,
                          padding: 20,
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),

              
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddListWidget(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Container eventDateTime(String event, date, time,
      {double? topLeft,
      double? topRight,
      Color? color,
      double? fontSize,
      double? padding}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft ?? 0),
            topRight: Radius.circular(topRight ?? 0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding ?? 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Event name
            BigTextWidget(
              text: event,
              fontSize: fontSize ?? 12,
            ),

            // Date
            BigTextWidget(
              text: date,
              fontSize: fontSize ?? 12,
            ),

            //Time
            BigTextWidget(
              text: time,
              fontSize: fontSize ?? 12,
            )
          ],
        ),
      ),
    );
  }
}
