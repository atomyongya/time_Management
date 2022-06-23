import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:time_management_application/screen/dashboard/day_count/daycount.dart';
import 'package:time_management_application/screen/dashboard/home.dart';
import 'package:time_management_application/screen/dashboard/note_screen/note.dart';
import 'package:time_management_application/screen/dashboard/notify_screen/notify.dart';
import 'package:time_management_application/screen/dashboard/timetable_screen/timetable.dart';
import 'package:time_management_application/screen/login/login.dart';
import 'package:time_management_application/screen/otp/otp.dart';
import 'package:time_management_application/screen/registration/registration.dart';

class NavigatorWidget extends StatefulWidget {
  const NavigatorWidget({Key? key}) : super(key: key);
  @override
  State<NavigatorWidget> createState() => _NavigatorWidget();
}

class _NavigatorWidget extends State<NavigatorWidget> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "Time Management Application",
        debugShowCheckedModeBanner: false,
        initialRoute: "/signin",
        routes: {
          "/signin": (context) => const LoginScreen(),
          "/signup": (context) => const RegistrationScreen(),
          "/": (context) => const HomeScreen(),
          "/otp": (context) => const OtpScreen(),
          "/notify": (context) => const NotifyScreen(),
          "/note": (context) => const NoteScreen(),
          "/timetable": (context) => const TimeTableScreen(),
          "/daycount": (context) => const DayCountScreen(),
        });
  }
}
