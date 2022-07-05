import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:time_management_application/api/user_authentication.dart';
import 'package:time_management_application/utils/colors.dart';
import 'package:time_management_application/utils/dimensions.dart';
import 'package:time_management_application/widgets/big_text.dart';
import 'package:http/http.dart' as http;

class AddListWidget extends StatefulWidget {
  const AddListWidget({Key? key}) : super(key: key);

  @override
  State<AddListWidget> createState() => _AddListWidgetState();
}

class _AddListWidgetState extends State<AddListWidget> {
  DateTime? _date = DateTime.now();
  TimeOfDay? _time = const TimeOfDay(hour: 5, minute: 00);
  final _eventController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          bottom: Dimensions.height10 * 12,
          left: Dimensions.width10 * 2,
          right: Dimensions.width10 * 2,
          top: Dimensions.height10 * 12,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.whiteColor,
            width: 0.1,
          ),
        ),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: Dimensions.height10,
                left: Dimensions.width10,
                right: Dimensions.width10,
                top: Dimensions.height10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top Section
                  Container(
                    padding: EdgeInsets.only(
                      bottom: Dimensions.height10 * 2,
                      left: Dimensions.width10 * 2,
                      right: Dimensions.width10 * 2,
                      top: Dimensions.height10 * 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BigTextWidget(
                          text: "Add new events.",
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.close,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Event Name
                  TextFormField(
                    controller: _eventController,
                    decoration: const InputDecoration(
                      hintText: "Event Name",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Date
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(3000),
                      ).then((value) => setState(() {
                            _date = value;
                          }));
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: Dimensions.height10,
                        left: Dimensions.width10 * 2,
                        right: Dimensions.width10 * 2,
                        top: Dimensions.height10,
                      ),
                      color: Colors.lightBlue,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${_date!.year}-${_date!.month.toString().length == 1 ? '0${_date!.month}' : _date!.month}-${_date!.day.toString().length == 1 ? '0${_date!.day}' : _date!.day}",
                            style: const TextStyle(color: AppColors.whiteColor),
                          ),
                          const Icon(
                            Icons.calendar_month,
                            color: AppColors.whiteColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Time
                  InkWell(
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 5, minute: 00),
                      ).then((value) => setState(
                            () => _time = value,
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: Dimensions.height10,
                        left: Dimensions.width10 * 2,
                        right: Dimensions.width10 * 2,
                        top: Dimensions.height10,
                      ),
                      color: Colors.lightBlue,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _time!.format(context).toString(),
                            style: const TextStyle(color: AppColors.whiteColor),
                          ),
                          const Icon(
                            Icons.alarm,
                            color: AppColors.whiteColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      _addEventList();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _addEventList() async {
    try {
      final date =
          "${_date!.year}-${_date!.month.toString().length == 1 ? '0${_date!.month}' : _date!.month}-${_date!.day.toString().length == 1 ? '0${_date!.day}' : _date!.day}";
      final time = _time!.format(context).toString();
      final data = {
        "event": _eventController.text,
        "date": date,
        "time": time,
      };

      http.Response response =
          await UserAuthentication().postData(data, "createEvent");

      final body = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(body.toString());
        if (!mounted) return;
        // If successfully pushed in the backend..
        Navigator.pushNamed(context, "/notify");
      } else {
        log("Error from _addEventList");
        const message = "Sorry something went wrong";
        const snackBar = SnackBar(content: Text(message));
        if (!mounted) return;
        return ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (error) {
      log("Error from _addEventList\n$error");
      const message = "Sorry something went wrong";
      const snackBar = SnackBar(content: Text(message));
      if (!mounted) return;
      return ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
