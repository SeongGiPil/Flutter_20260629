import 'package:flutter/material.dart';

// 프로그램 시작
void main() {
  // MyApp 위젯을 실행
  runApp(const MyApp());
}

// 메인 화면 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // 계산기 버튼에 표시할 문자열 리스트
    List<String> labels = [
      'C', '(', '%', '/',
      '7', '8', '9', '*',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '0', '00', '.', '='
    ];

    // Material 디자인 앱 시작
    return MaterialApp(

      // 기본 화면
        home : Scaffold(

          // 상단 앱바
            appBar: AppBar(title : Text("계산기")),

            // 화면 본문
            body : Column(

              children: [

                // 남은 공간을 모두 GridView가 차지하도록 설정
                Expanded(

                  // 버튼을 Grid 형태로 자동 생성
                  child: GridView.builder(

                    // Grid(격자) 설정
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                      // 한 줄에 버튼 4개씩 배치
                        crossAxisCount: 4,

                        // 버튼 사이 세로 간격
                        mainAxisSpacing: 6,

                        // 버튼 사이 가로 간격
                        crossAxisSpacing: 6
                    ),

                    // 버튼 개수 = labels 리스트 개수
                    itemCount: labels.length,

                    // 버튼을 하나씩 생성
                    itemBuilder: (context, index) {

                      return ElevatedButton(

                        // 버튼 클릭 이벤트
                          onPressed: (){},

                          // 버튼 안에 표시될 글자
                          child: Text(
                            labels[index],
                            style: TextStyle(
                                color : Colors.black, // 글자색
                                fontSize: 30          // 글자크기
                            ),
                          ),

                          // 버튼 디자인 설정
                          style: ElevatedButton.styleFrom(

                            // 버튼 배경색 지정
                            // 첫 번째 줄(C,(,%,/) 또는
                            // 4번째마다 있는 연산자(/,*,-,+,=)는 파란색
                            // 나머지는 회색
                              backgroundColor:
                              (index+1) % 4 == 0 || index < 4
                                  ? Colors.blue[100]
                                  : Colors.grey[100],

                              // 버튼 모서리를 네모로 설정
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero
                              )
                          )
                      );
                    },
                  ),
                )
              ],
            )
        )
    );
  }
}