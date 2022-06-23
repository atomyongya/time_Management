import "package:flutter/material.dart";

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreen();
}

class _NoteScreen extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Note Page"),
    );
  }
}
