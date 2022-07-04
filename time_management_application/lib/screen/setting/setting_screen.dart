import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton.icon(
          onPressed: () async {
            final preference = await SharedPreferences.getInstance();
            preference.remove("email");
            if (!mounted) return;
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/signin",
              (route) => false,
            );
          },
          icon: const Icon(Icons.logout),
          label: const Text("Logout")),
    ));
  }
}
