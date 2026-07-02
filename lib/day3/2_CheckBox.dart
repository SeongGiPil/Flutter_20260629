import 'package:flutter/material.dart';

// 프로그램 시작
void main() {
  // MyApp 위젯 실행
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
bool? javaChecked=false;
bool mysqlChecked=false;
@override
Widget build(BuildContext context) {
return MaterialApp(
home: Scaffold(
body: ListView(
children: [
CheckboxListTile(
value: javaChecked,
controlAffinity: ListTileControlAffinity.leading,
title: Text("자바"),
subtitle: Text("자바 재밌는사람?"),
onChanged: (value) {
setState(() {
javaChecked = value!;
});
},
),
],
),
),
);
}
}