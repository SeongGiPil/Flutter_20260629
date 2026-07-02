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
              groupValue: subject,
              title: Text("자바"),
              onChanged: (value) {
                setState(() {
                  subject = value!;
                });
              },
            ),
            RadioListTile(
              value: "mysql",
              groupValue: subject,
              title: Text("mySql"),
              onChanged: (value) {
                setState(() {
                  subject = value!;
                });
              },
            ),
            RadioListTile(
              value: "flutter",
              groupValue: subject,
              title: Text("Flutter"),
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