import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            // 한 번 터치
            onTap: () {
              print("Tap!");
            },

            // 두 번 터치
            onDoubleTap: () {
              print("Double Tap!");
            },

            // 길게 누르기
            onLongPress: () {
              print("Long Press!");
            },

            // 터치할 대상 위젯
            child: Image.asset("assets/image1.jpeg"),
          ),
        ),
      ),
    );
  }
}