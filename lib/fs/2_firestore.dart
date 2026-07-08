import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

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

// 앱 시작 위젯
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Firestore DB 객체
  FirebaseFirestore fs = FirebaseFirestore.instance;

  // 이름 입력창 값을 가져오는 컨트롤러
  TextEditingController namectrl = TextEditingController();

  // 나이 입력창 값을 가져오는 컨트롤러
  TextEditingController agectrl = TextEditingController();

  // 수정할 문서 ID 저장용
  // 목록에서 사용자를 클릭하면 doc.id가 여기에 저장됨
  String? selectedDocId;

  // 사용자 추가 함수
  Future<void> addUser() async {
    // 입력값을 Firestore에 저장할 Map으로 만들기
    Map<String, dynamic> user = {
      "name": namectrl.text,
      "age": int.parse(agectrl.text),
      "cdate": Timestamp.now(),
    };

    // users 컬렉션에 데이터 추가
    await fs.collection("users").add(user);

    // 입력창 비우기
    namectrl.clear();
    agectrl.clear();

    print("저장 완료");
  }

  // 사용자 수정 함수
  Future<void> updateUser() async {
    // 선택한 문서가 없으면 수정 불가
    if (selectedDocId == null) {
      print("수정할 사용자를 먼저 선택하세요");
      return;
    }

    // 선택한 문서 ID를 기준으로 데이터 수정
    await fs.collection("users").doc(selectedDocId).update({
      "name": namectrl.text,
      "age": int.parse(agectrl.text),
    });

    // 수정 후 입력창 비우기
    namectrl.clear();
    agectrl.clear();

    // 선택 문서 초기화
    selectedDocId = null;

    print("수정 완료");
  }

  // 사용자 목록 출력 함수
  Widget getUserList() {
    return StreamBuilder<QuerySnapshot>(
      // users 컬렉션을 실시간으로 감시
      stream: fs.collection("users").snapshots(),

      builder: (context, snapshot) {
        // 데이터 로딩 중
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // users 컬렉션의 문서 목록
        final docs = snapshot.data!.docs;

        // 문서 목록을 화면에 출력
        return ListView(
          children: docs.map((doc) {
            return ListTile(
              leading: const Icon(Icons.person),

              // 문서 ID 출력
              title: Text("문서ID: ${doc.id}"),

              // 이름, 나이 출력
              subtitle: Text(
                "이름: ${doc["name"]}, 나이: ${doc["age"]}",
              ),

              // 목록 클릭 시 수정할 데이터 선택
              onTap: () {
                // 클릭한 문서 ID 저장
                selectedDocId = doc.id;

                // 클릭한 데이터 입력창에 넣기
                namectrl.text = doc["name"];
                agectrl.text = doc["age"].toString();

                print("수정할 사용자 선택됨");
              },

              // 오른쪽 삭제 버튼
              trailing: IconButton(
                icon: const Icon(Icons.delete),

                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("삭제"),
                        content: const Text("정말 삭제하시겠습니까?"),
                        actions: [
                          // 취소 버튼
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("취소"),
                          ),

                          // 삭제 버튼
                          TextButton(
                            onPressed: () async {
                              // 선택한 문서 삭제
                              await fs
                                  .collection("users")
                                  .doc(doc.id)
                                  .delete();

                              // 팝업 닫기
                              Navigator.of(context).pop();

                              print("삭제 완료");
                            },
                            child: const Text("삭제"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // DEBUG 띠 제거
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          title: const Text("파이어스토어"),
        ),

        body: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              // 이름 입력창
              TextField(
                controller: namectrl,
                decoration: const InputDecoration(
                  labelText: "이름",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              // 나이 입력창
              TextField(
                controller: agectrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "나이",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              // 저장 / 수정 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 새 사용자 저장
                  ElevatedButton(
                    onPressed: addUser,
                    child: const Text("저장"),
                  ),

                  const SizedBox(width: 10),

                  // 선택한 사용자 수정
                  ElevatedButton(
                    onPressed: updateUser,
                    child: const Text("수정"),
                  ),
                ],
              ),

              const Divider(height: 30),

              // 사용자 목록
              Expanded(
                child: getUserList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}