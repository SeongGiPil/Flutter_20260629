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
      top: 150,
      left: 150,
      child: Container(
        height: 100,
        width: 100,
        color: Colors.greenAccent,
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