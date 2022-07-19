import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import "package:flutter/material.dart";
import 'package:time_management_application/api/get_event.dart';
import 'package:time_management_application/models/event_model.dart';
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
  Future _loadData() async {
    try {
      http.Response response = await GetEvent().getEvent("getEvent");
      var jsonData = json.decode(response.body);
      List<EventModel> eventList = [];
      final removeDuplicat = eventList.toSet().toList();
      for (var data in jsonData) {
        EventModel model =
            EventModel(data["event"], data["date"], data["time"]);
        removeDuplicat.add(model);
      }
      return removeDuplicat;
    } catch (error) {
      log("Error in _loadData\n$error");
    }
  }

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
                child: FutureBuilder(
                  future: _loadData(),
                  builder: (context, AsyncSnapshot snapShot) {
                    if (snapShot.data == null) {
                      return const Center(
                        child: BigTextWidget(text: "Noting to Display"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapShot.data.length,
                        itemBuilder: (context, valueIndex) {
                          return Column(
                            children: [
                              eventDateTime(
                                snapShot.data[valueIndex].event,
                                snapShot.data[valueIndex].date,
                                snapShot.data[valueIndex].time,
                                color: Colors.lightBlueAccent,
                                fontSize: 13,
                                padding: 20,
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
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

  Container eventDateTime(event, date, time,
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
