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
  Offset p = const Offset(100, 150);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            ...List.generate(10, (index) {
              return Positioned(
                top: 150,
                left: 100 + (50.0 * index),
                child: Container(
                  height: 50,
                  width: 40,
                  color: Colors.purple,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}