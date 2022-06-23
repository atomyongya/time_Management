import "package:flutter/material.dart";

class NotifyScreen extends StatefulWidget {
  const NotifyScreen({Key? key}) : super(key: key);

  @override
  State<NotifyScreen> createState() => _NotifyScreen();
}

class _NotifyScreen extends State<NotifyScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Notify Page"),
    );
  }
}
