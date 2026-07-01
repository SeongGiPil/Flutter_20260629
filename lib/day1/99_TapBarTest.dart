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
appBar:AppBar()
),
title:Text("테스트!"),
),
    drawer:Drawer(),
    body:Center(


    child:Column(
    mainAxisAlignment: mainAxisAligement.center,
    children: [
Text("가운데",style:Textstyle(fontSize:50,fontWeight:fontWeight.bold)),
IconButton(onProssed: (){},icon:Icon(Icons.star,color:Colors.yellow,size:50,)),

]
Column
)