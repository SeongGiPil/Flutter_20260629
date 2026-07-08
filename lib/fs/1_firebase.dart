// Firestore 데이터베이스를 사용하기 위한 패키지
import 'package:cloud_firestore/cloud_firestore.dart';

// Flutter 화면을 만들기 위한 기본 패키지
import 'package:flutter/material.dart';

// Firebase를 Flutter 앱에서 시작하기 위한 패키지
import 'package:firebase_core/firebase_core.dart';

// Firebase 프로젝트 설정 정보가 들어있는 파일
import '../firebase_options.dart';

// 프로그램 시작 부분
void main() async {
  // Firebase 사용 전에 Flutter 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 연결
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 앱 실행
  runApp(const MyApp());
}

// 앱의 메인 클래스
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Firestore DB 객체 생성
    final FirebaseFirestore fs = FirebaseFirestore.instance;

    // 사용자 추가 함수
    Future<void> addUser() async {
      // Firestore에 저장할 데이터
      Map<String, dynamic> user = {
        "name": "김철수",
        "age": 20,
        "cdate": Timestamp.now(),
      };

      // users 컬렉션에 user 데이터 추가
      // add()는 문서 ID를 자동 생성함
      await fs.collection("users").add(user);

      print("사용자 추가 완료");
    }

    // 사용자 조회 함수
    Future<void> getUserList() async {
      // users 컬렉션에서 age가 20 이상인 데이터 조회
      final snapshot = await fs
          .collection("users")
          .where("age", isGreaterThanOrEqualTo: 20)
          .orderBy("age", descending: true)
          .get();

      // 조회된 문서들을 하나씩 출력
      for (var doc in snapshot.docs) {
        Map<String, dynamic> user = doc.data();

        print(
          "문서 ID: ${doc.id}, "
              "이름: ${user["name"]}, "
              "나이: ${user["age"]}",
        );
      }
    }

    // 사용자 수정 함수
    Future<void> updateUser() async {
      // 수정할 문서 ID
      // Firestore 콘솔에서 실제 문서 ID로 바꿔야 함
      String docId = "RSdq9ycsix9Gem1XHr1A";

      // users 컬렉션에서 해당 문서 수정
      await fs.collection("users").doc(docId).update({
        "name": "박영희",
        "age": 25,
      });

      print("사용자 수정 완료");
    }

    // 사용자 삭제 함수
    Future<void> deleteUser() async {
      // 삭제할 문서 ID
      // Firestore 콘솔에서 실제 문서 ID로 바꿔야 함
      String docId = "RSdq9ycsix9Gem1XHr1A";

      // users 컬렉션에서 해당 문서 삭제
      await fs.collection("users").doc(docId).delete();

      print("사용자 삭제 완료");
    }

    // 화면 UI
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Firestore CRUD"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 추가 버튼
              ElevatedButton(
                onPressed: addUser,
                child: const Text("추가!"),
              ),

              // 조회 버튼
              ElevatedButton(
                onPressed: getUserList,
                child: const Text("읽기!"),
              ),

              // 수정 버튼
              ElevatedButton(
                onPressed: updateUser,
                child: const Text("수정!"),
              ),

              // 삭제 버튼
              ElevatedButton(
                onPressed: deleteUser,
                child: const Text("삭제!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}