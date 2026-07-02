import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String subject = "java";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            RadioListTile(
              value: "java",
              title: const Text("자바"),
              groupValue: subject,
              onChanged: (value) {
                setState(() {
                  subject = value!;
                });
              },
            ),
            RadioListTile(
              value: "mysql",
              title: const Text("mysql"),
              groupValue: subject,
              onChanged: (value) {
                setState(() {
                  subject = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}