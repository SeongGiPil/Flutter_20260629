import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),   // ← Scaffold 대신 MyHome 위젯을 넣음
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {   // ← 이 context는 Scaffold 자체를 만드는 context
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("졸리다"),
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                    label: "닫기",
                    onPressed: (){

                    }),
              ),
            );
          },
          child: Text("클릭"),
        ),
      ),
    );
  }
}