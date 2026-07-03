import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _State();
}

class _State extends State<MyApp> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _controllerCenter.play();
                },
                child:Text("클릭"),
              ),
              ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirection: pi,
                particleDrag: 0.05,
                emissionFrequency: 0.05,
                numberOfParticles: 4000,
                gravity: 0.05,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.yellow,
                ],
                strokeWidth: 1,
                strokeColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}