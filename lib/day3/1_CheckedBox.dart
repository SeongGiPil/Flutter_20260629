import 'package:flutter/material.dart';

// 프로그램 시작
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool javaChecked = false;
  bool mysqlChecked = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("체크박스 예제"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: javaChecked,
                  onChanged: (value) {
                    setState(() {
                      javaChecked = value!;
                    });
                  },
                ),
                const Text("자바"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: mysqlChecked,
                  onChanged: (value) {
                    setState(() {
                      mysqlChecked = value!;
                    });
                  },
                ),
                const Text("MySQL"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}