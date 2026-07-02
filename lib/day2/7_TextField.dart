import 'package:flutter/material.dart';

// 프로그램 시작
void main() {
  // MyApp 위젯 실행
  runApp(const MyApp());
}

// 메인 화면 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // TextField의 값을 제어하기 위한 컨트롤러
    TextEditingController idCtrl = TextEditingController();

    // 계산기 버튼에 사용할 문자 목록
    List<String> labels = [
      'C', '(', '%', '/',
      '7', '8', '9', '*',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '0', '00', '.', '='
    ];

    return MaterialApp(
        home : Scaffold(

          // 상단 앱바
            appBar: AppBar(title : Text("계산기")),

            // 화면 전체에 15만큼 여백 적용
            body : Padding(
              padding: const EdgeInsets.all(15),

              // 세로 방향으로 위젯 배치
              child: Column(
                children: [

                  // 숫자 및 계산식을 입력하는 입력창
                  TextField(

                    // 입력창과 컨트롤러 연결
                    controller: idCtrl,

                    // obscureText: true, // 비밀번호처럼 숨김 처리

                    decoration: InputDecoration(

                      // 입력창 위에 표시되는 라벨
                      labelText: "숫자",

                      // 아무것도 입력되지 않았을 때 표시
                      hintText: "숫자 입력",

                      // 왼쪽 아이콘
                      prefixIcon: Icon(Icons.calculate),

                      // 오른쪽 아이콘
                      suffixIcon: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),

                      // 입력창 테두리
                      border : OutlineInputBorder(),

                      // 배경색 사용 여부
                      filled: true,

                      // 입력창 배경색
                      fillColor: Colors.grey[100],

                      // enabled: false // 입력 비활성화
                    ),
                  ),

                  // 입력창과 버튼 사이 간격
                  SizedBox(height: 10,),

                  // 남은 공간을 GridView가 모두 차지
                  Expanded(

                    // 버튼들을 격자(Grid) 형태로 생성
                    child: GridView.builder(

                      // Grid의 행과 열 설정
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                        // 한 줄에 버튼 4개
                          crossAxisCount: 4,

                          // 버튼 사이 세로 간격
                          mainAxisSpacing: 6,

                          // 버튼 사이 가로 간격
                          crossAxisSpacing: 6
                      ),

                      // 버튼 개수
                      itemCount: labels.length,

                      // 버튼 하나씩 생성
                      itemBuilder: (context, index) {

                        return ElevatedButton(

                          // 버튼 클릭 이벤트
                          onPressed: (){},

                          // 버튼 안에 표시될 문자
                          child: Text(
                            labels[index],
                            style: TextStyle(
                                color : Colors.black,
                                fontSize: 30
                            ),
                          ),

                          // 버튼 디자인 설정
                          style: ElevatedButton.styleFrom(

                            // 첫 줄(C,(,%,/)과
                            // 4번째 열(/,*,-,+,=)은 파란색
                            // 나머지 숫자 버튼은 회색
                              backgroundColor:
                              (index+1) % 4 == 0 || index < 4
                                  ? Colors.blue[100]
                                  : Colors.grey[100],

                              // 버튼 모서리를 직각으로 설정
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero
                              )
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}