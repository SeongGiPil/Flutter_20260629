import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Circular Percent Indicator"),
        ),
        body: Center(
          child: CircularPercentIndicator(
            radius: 100.0,          // 원 크기
            lineWidth: 10.0,        // 원 두께
            percent: 0.8,           // 80%
            header: const Text("Icon Header"),
            center: const Icon(
              Icons.person_pin,
              size: 50,
              color: Colors.blue,
            ),
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
            animation: true,
            animationDuration: 1000,
          ),
        ),
      ),
    );
  }
}