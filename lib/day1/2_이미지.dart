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
        appBar: AppBar(title: Text("상단영역")),
        body: Center(
          child: Column(
            children: [
              Image.asset("assets/image1.jpeg",width:200,height:200,),
              CircleAvatar(
                radius:100,
                backgroundImage: AssetImage("assets/image1.jpeg"),
              )
            ],
          ),
        ),
      ),
    );
  }
}