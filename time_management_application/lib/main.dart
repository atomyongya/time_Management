import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_management_application/screen/dashboard/day_count/daycount.dart';
import 'package:time_management_application/screen/dashboard/home.dart';
import 'package:time_management_application/screen/dashboard/note_screen/note.dart';
import 'package:time_management_application/screen/dashboard/notify_screen/notify.dart';
import 'package:time_management_application/screen/dashboard/timetable_screen/timetable.dart';
import 'package:time_management_application/screen/login/login.dart';
import 'package:time_management_application/screen/otp/otp.dart';
import 'package:time_management_application/screen/registration/registration.dart';
import 'package:time_management_application/screen/setting/setting_screen.dart';

void main() async {
  runApp(const TimeManagement());
  await AndroidAlarmManager.initialize();
}

class TimeManagement extends StatefulWidget {
  const TimeManagement({Key? key}) : super(key: key);

  @override
  State<TimeManagement> createState() => _TimeManagement();
}

class _TimeManagement extends State<TimeManagement> {
  Widget _initialScreen = const HomeScreen();

  @override
  void initState() {
    super.initState();
    _checkUserCredintials();
  }

  _checkUserCredintials() async {
    final preference = await SharedPreferences.getInstance();
    if (preference.getString("email") != null) {
      setState(() {
        _initialScreen = const HomeScreen();
      });
    } else {
      setState(() {
        _initialScreen = const LoginScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Time Management",
      initialRoute: "/",
      routes: {
        "/": (context) => _initialScreen,
        "/home": (context) => const HomeScreen(),
        "/signin": (context) => const LoginScreen(),
        "/signup": (context) => const RegistrationScreen(),
        "/otp": (context) => const OtpScreen(),
        "/notify": (context) => const NotifyScreen(),
        "/note": (context) => const NoteScreen(),
        "/timetable": (context) => const TimeTableScreen(),
        "/daycount": (context) => const DayCountScreen(),
        "/settings": (context) => const SettingScreen(),
      },
    );
  }
}
