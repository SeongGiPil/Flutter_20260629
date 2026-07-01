import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.blueAccent
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("타이틀!",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue,
              letterSpacing: 2,
              decoration: TextDecoration.underline,
              decorationColor: Colors.deepPurple,
              decorationStyle: TextDecorationStyle.dashed,
            ),

          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            IconButton(onPressed: () {}, icon: Icon(Icons.home)),

          ],
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              print("버튼클릭!");
            },
            child: Text("선택!!"),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.green,
                shadowColor: Colors.black,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                side: BorderSide(
                    color: Color(0x1A0202),
                    width: 1
                )
            ),

          ),

        ),
        bottomNavigationBar: BottomAppBar(),

      ),

    );
  }
  }
