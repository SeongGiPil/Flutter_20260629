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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("삭제"),
                    content: const Text("정말삭제???"),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          print("삭제");
                          Navigator.of(context).pop();
                        },
                        child: const Text("삭제"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("취소"),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text("삭제창 열기"),
          ),
        ),
      ),
    );
  }
}