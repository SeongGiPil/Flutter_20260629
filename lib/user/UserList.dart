// Flutter의 Material Design 위젯 사용
import 'package:flutter/material.dart';

// DB 관련 기능을 사용하기 위해 import
// DB.selectUserList() 함수 사용
import 'DB.dart';


// 사용자 목록 화면
// DB 조회 후 화면을 변경해야 하므로 StatefulWidget 사용
class UserList extends StatefulWidget {
  const UserList({super.key});

  @override

  // UserList의 상태 관리 클래스 연결
  State<UserList> createState() => _UserListState();
}


// UserList 화면의 상태를 관리하는 클래스
class _UserListState extends State<UserList> {

  // DB에서 조회한 사용자 목록을 저장하는 리스트
  //
  // Map 한 개의 예:
  // {
  //   "userId": 1,
  //   "name": "홍길동",
  //   "age": 20
  // }
  List<Map<String, dynamic>> list = [];


  // DB에서 사용자 목록을 조회하는 함수
  Future<void> _selectUserList() async {

    // DB의 selectUserList() 실행
    // 조회 결과를 tempList에 저장
    var tempList = await DB.selectUserList();

    // 조회 결과를 list에 저장하고 화면을 다시 그림
    setState(() {
      list = tempList;
    });
  }


  // 화면이 처음 생성될 때 한 번 실행되는 함수
  @override
  void initState() {

    // 부모 클래스의 initState 실행
    super.initState();

    // 화면이 처음 실행될 때 사용자 목록 조회
    _selectUserList();
  }


  @override
  Widget build(BuildContext context) {

    // list의 두 번째 데이터(index 1)의 name 출력
    //
    // 주의:
    // DB 조회 전에 build()가 먼저 실행될 수 있기 때문에
    // list에 데이터가 2개 미만이면 오류가 발생할 수 있음
    print(list[1]["name"]);


    // 기본 화면 구조
    return Scaffold(

      // 상단 앱바
      appBar: AppBar(

        // 앱바 제목
        title: Text("사용자 목록"),
      ),


      // 사용자 목록 출력
      body: ListView.builder(

        // 현재는 리스트를 무조건 3개 생성
        itemCount: 3,

        // index 값에 따라 ListTile을 반복 생성
        itemBuilder: (context, index) {

          // 목록 한 줄을 표현하는 위젯
          return ListTile(

            // 목록 왼쪽 아이콘
            leading: Icon(Icons.home),

            // 목록의 제목
            title: Text("집 고고"),

            // 제목 아래의 설명
            subtitle: Text("고고~~~"),

            // 목록 오른쪽 영역
            trailing: Row(

              // Row가 필요한 크기만 차지하도록 설정
              mainAxisSize: MainAxisSize.min,

              children: [

                // 수정 아이콘
                Icon(Icons.edit),

                // 삭제 아이콘
                Icon(Icons.delete),
              ],
            ),
          );
        },
      ),
    );
  }
}