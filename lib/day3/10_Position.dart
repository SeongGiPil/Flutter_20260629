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
  Offset p=Offset(100,150);
  
  List<Widget> list = [
    Positioned(
      top: 20,
      left: 20,
      child: Container(
        height: 50,
        width: 50,
        color: Colors.greenAccent,
      ),
    ),
    Positioned(
      top: 80,
      left: 80,
      child: Container(
        height: 50,
        width: 50,
        color: Colors.redAccent,
      ),
    ),
    Positioned(
      top: 140,
      left: 140,
      child: Container(
        height: 50,
        width: 50,
        color: Colors.blueAccent,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: list,
        ),
      ),
    );
  }
}