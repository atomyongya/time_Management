import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:time_management_application/screen/dashboard/home.dart';
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
        });
  }
}
