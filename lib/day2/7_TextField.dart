import 'package:flutter/material.dart';

// 프로그램 시작
void main() {
  // MyApp 위젯을 실행
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController idctrl=TextEditingController();
  var test=1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home:Scaffold(
       body:Center(
         child:Padding(
           padding:const EdgeInsets.all(30),

         child:Column(
           mainAxisAlignment: MainAxisAlignment.center,
          
           children:[
             TextField(
               controller: idctrl,
               obscureText: true,
               decoration: InputDecoration(
                 labelText:"아이디",
                 hintText:"ex) test1234",
                   prefixIcon:Icon(Icons.perm_identity),
                 suffixIcon: Icon(Icons.check_circle,color:Colors.green),
                   border:OutlineInputBorder(),
                 filled: true,
                 fillColor: Colors.yellow[100],
                  // enabled: false
               ),
             ),
             SizedBox(height:20,),
             ElevatedButton(
                 onPressed:(){
                   print("입력된아이디:${idctrl.text}");
                 },
                 child:Text("로그인")
             )
             ],




         ),
         ),
       ),
       ),

    );

  }
}
