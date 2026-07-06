import 'package:flutter/material.dart';

class BPage extends StatelessWidget {
  final String? msg;
  const BPage({super.key,this.msg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("B페이지"),


      ),
      body:Center(
        child:Text(msg?? "B페이지 ! 전달 받은 값 없음 !"),
      ),
    );
  }
}

