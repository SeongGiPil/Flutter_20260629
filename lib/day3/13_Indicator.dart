import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class  extends StatefulWidget {
  const ({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: new AppBar(
title: new Text("Circular Percent Indicators"),
),
body: Center(
child: ListView(
children: <Widget>[
new CircularPercentIndicator(
radius: 100.0,
lineWidth: 10.0,
percent: 0.8,
header: new Text("Icon header"),
center: new Icon(
Icons.person_pin,
size: 50.0,
color: Colors.blue,
),
backgroundColor: Colors.grey,
progressColor: Colors.blue,
),

),
},
),
)
),
};