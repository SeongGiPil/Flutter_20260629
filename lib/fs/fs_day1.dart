import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FsScreen(),
    );
  }
}

class FsScreen extends StatelessWidget {
  const FsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore fs = FirebaseFirestore.instance;

    // 사용자 추가 함수
    Future<void> addUser() async {

      // 저장할 데이터
      Map<String, dynamic> user = {
        "name": "김철수",
        "age": 20,
        "cdate": Timestamp.now(),
      };

      // users 컬렉션에
      // 문서 ID를 abcd로 직접 지정해서 저장
      await fs
          .collection("users")
          .doc("abcd")
          .set(user);

      print("사용자 추가 완료");
    }

    Future<void> getUserList() async{
      final snapshot=
      await fs.collection("users")
          .where("age",isGreaterThanOrEqualTo: 25)//age>=25
          .orderBy("age",)

          .get();


    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore 실습"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            addUser();
          },
          child: const Text("사용자 추가"),
        ),
      ),
    );
  }
}