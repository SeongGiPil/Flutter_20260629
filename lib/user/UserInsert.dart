import 'package:flutter/material.dart';

// SQLite DB 관련 기능이 작성된 파일 import
// 사용자 추가(insertUser) 등의 기능 사용
import 'DB.dart';

// 사용자 목록 화면 import
import 'UserList.dart';


// 프로그램 시작점
void main(){

  // UserInsert 위젯 실행
  runApp(const UserInsert());
}


// 앱의 시작 위젯
// 화면 상태 변경이 필요 없으므로 StatelessWidget 사용
class UserInsert extends StatelessWidget {
  const UserInsert({super.key});

  @override
  Widget build(BuildContext context) {

    // Material 디자인을 사용하는 앱 생성
    return MaterialApp(

      // 처음 실행할 화면 지정
      home: UserInsertScreen(),
    );
  }
}


// 사용자 입력 화면
// TextField 입력 및 화면 상태 관리가 필요하므로 StatefulWidget 사용
class UserInsertScreen extends StatefulWidget {
  const UserInsertScreen({super.key});

  @override

  // State 클래스 연결
  State<UserInsertScreen> createState() => _UserInsertScreenState();
}


// UserInsertScreen의 상태를 관리하는 클래스
class _UserInsertScreenState extends State<UserInsertScreen> {

  // 이름 입력창의 값을 관리하는 컨트롤러
  TextEditingController nameCtrl = TextEditingController();

  // 나이 입력창의 값을 관리하는 컨트롤러
  TextEditingController ageCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {

    // 기본적인 화면 구조 제공
    return Scaffold(

      // 상단 앱바
      appBar: AppBar(

        // 앱바 제목
        title : Text("sqflite 실습"),

        // 앱바 오른쪽에 표시할 위젯 목록
        actions: [

          // 사용자 목록 페이지 이동 버튼
          IconButton(

            // 버튼 클릭 시 실행
              onPressed: (){

                // UserList 화면으로 이동
                Navigator.push(
                    context,

                    // 새로운 화면 경로 생성
                    MaterialPageRoute(

                      // 이동할 화면 지정
                      builder: (context) => UserList(),
                    )
                );
              },

              // 목록 아이콘
              icon: Icon(Icons.list)
          )
        ],
      ),


      // 화면 본문
      body: Padding(

        // 화면 전체에 20만큼 여백 설정
        padding: EdgeInsets.all(20),

        // 위젯을 세로 방향으로 배치
        child: Column(

          children: [

            // 이름 입력창
            TextField(

              // 입력값을 nameCtrl로 관리
              controller: nameCtrl,

              // 입력창 디자인 설정
              decoration: InputDecoration(

                // 입력창 제목
                  labelText: "이름"
              ),
            ),


            // 나이 입력창
            TextField(

              // 입력값을 ageCtrl로 관리
              controller: ageCtrl,

              decoration: InputDecoration(

                // 입력창 제목
                  labelText: "나이"
              ),
            ),


            // 위젯 사이에 세로 여백 10 추가
            SizedBox(height: 10,),


            // 사용자 추가 버튼
            ElevatedButton(

              // 버튼 클릭 시 실행
              // DB 작업을 기다려야 하므로 async 사용
                onPressed: () async {

                  // 이름 입력창의 값을 String으로 가져오기
                  String name = nameCtrl.text;

                  // 나이 입력값을 int 타입으로 변환
                  // 숫자 변환 실패 시 0 저장
                  int age = int.tryParse(ageCtrl.text) ?? 0;


                  // DB의 insertUser 함수 실행
                  // 이름과 나이를 DB에 저장
                  await DB.insertUser(name, age);


                  // DB 저장 완료 후 이름 입력창 초기화
                  nameCtrl.clear();

                  // 나이 입력창 초기화
                  ageCtrl.clear();
                },

                // 버튼에 표시되는 글자
                child: Text("추가!")
            )
          ],
        ),
      ),
    );
  }
}