import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Random ran = Random();
  int ranNum = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            //화면중앙으로옴
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "랜덤한 숫자: $ranNum",
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    ranNum = ran.nextInt(10); // 0~9
                  });
                },
                child: const Text("랜덤 생성"),
              ),
            ],
          ),
        ),
      ),
    );
 }
}