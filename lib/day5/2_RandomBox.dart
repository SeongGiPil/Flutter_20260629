// Flutter 화면을 만들기 위한 패키지
import 'package:flutter/material.dart';

// 랜덤 값을 사용하기 위한 패키지
import 'dart:math';


// 프로그램 시작 위치
void main() {

  // MyApp 실행
  runApp(const MyApp());
}


// StatefulWidget 사용
// 박스 생성, 삭제 등 화면이 변경되기 때문에 StatefulWidget 사용
class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


// MyApp의 상태를 관리하는 클래스
class _MyAppState extends State<MyApp> {

  // 랜덤 숫자를 만들기 위한 객체
  Random ran = Random();


  // 화면에 출력할 박스들을 저장하는 리스트
  List<Widget> list = [];


  // 현재 클릭해야 하는 박스의 순서를 저장
  // 처음 값은 0
  int currentIndex = 0;



  // ==========================================
  // 랜덤 위치에 박스 10개를 만드는 함수
  // ==========================================
  void createBox() {

    // 새로 생성할 박스를 임시로 저장하는 리스트
    List<Widget> tempList = [];


    // 0부터 9까지 총 10번 반복
    // 반복 횟수 = 생성되는 박스 개수
    for (int i = 0; i < 10; i++) {

      // tempList에 박스 하나씩 추가
      tempList.add(

        // Stack 내부에서 위치를 지정하기 위해 Positioned 사용
        Positioned(

          // 박스의 가로 위치를 랜덤으로 설정
          //
          // ran.nextDouble()
          // → 0.0 이상 1.0 미만의 랜덤 숫자 생성
          //
          // 화면 너비 - 50
          // → 박스의 너비만큼 빼서 화면 오른쪽 밖으로
          //   넘어가는 것을 줄여줌
          left: ran.nextDouble() *
              (MediaQuery.of(context).size.width - 50),


          // 박스의 세로 위치를 랜덤으로 설정
          //
          // 화면 높이에서 150을 제외한 범위에서
          // 랜덤한 위치 생성
          top: ran.nextDouble() *
              (MediaQuery.of(context).size.height - 150),


          // 박스를 클릭할 수 있도록 GestureDetector 사용
          child: GestureDetector(

            // 박스를 클릭했을 때 실행
            onTap: () {

              // removeBox 함수 호출
              // 현재 코드에서는 i보다 1 작은 값을 전달
              //
              // 예:
              // 0번 박스 클릭 → -1 전달
              // 1번 박스 클릭 → 0 전달
              // 2번 박스 클릭 → 1 전달
              removeBox(i - 1);
            },


            // 실제 화면에 표시되는 박스
            child: Container(

              // 박스 너비
              width: 50,

              // 박스 높이
              height: 50,

              // 박스 배경색
              color: Colors.green[100],


              // 박스 안의 숫자를 중앙에 배치
              child: Center(

                // 반복문의 i를 출력
                // 화면에는 0 ~ 9가 표시됨
                child: Text("$i"),
              ),
            ),
          ),
        ),
      );
    }


    // 상태를 변경하고 화면을 다시 그림
    setState(() {

      // 기존 list를
      // 새로 생성한 tempList로 교체
      list = tempList;
    });
  }



  // ==========================================
  // 화면이 처음 생성될 때 한 번 실행
  // ==========================================
  @override
  void initState() {

    // 부모 클래스의 initState 실행
    super.initState();


    // 첫 화면이 완성된 후 실행
    //
    // createBox() 안에서 MediaQuery를 사용하기 때문에
    // 화면 생성 이후 실행하도록 함
    WidgetsBinding.instance.addPostFrameCallback((_) {

      // 처음 앱을 실행하면
      // 랜덤 박스 10개 생성
      createBox();
    });
  }



  // ==========================================
  // 박스를 삭제하는 함수
  // ==========================================
  void removeBox(int index) {

    // 현재 순서와 클릭한 박스의 index가 같은지 확인
    if (currentIndex == index) {

      // 순서가 맞으면 다음 숫자로 증가
      currentIndex++;
    }


    // 화면 상태 변경
    setState(() {

      // list의 첫 번째 박스 삭제
      //
      // removeAt(0)
      // → 리스트의 0번째 위치에 있는 요소 삭제
      list.removeAt(0);
    });
  }



  // ==========================================
  // 화면 UI 구성
  // ==========================================
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home: Scaffold(

        // 화면을 위아래로 배치
        body: Column(

          children: [

            // =================================
            // 박스가 표시되는 게임 영역
            // =================================
            Expanded(

              // 남은 화면 공간을 모두 사용
              child: Stack(

                // createBox()에서 만든 박스들을 화면에 출력
                //
                // Positioned는 Stack 안에서 사용해야 함
                children: list,
              ),
            ),


            // =================================
            // 하단 버튼 영역
            // =================================
            Container(

              // 버튼 영역 높이
              height: 50,

              // 배경색
              color: Colors.grey[100],


              // 버튼을 중앙에 배치
              child: Center(

                child: ElevatedButton(

                  // 버튼 클릭
                  onPressed: () {

                    // 랜덤 위치에 박스 10개를 다시 생성
                    createBox();
                  },

                  // 버튼에 표시되는 글자
                  child: const Text("랜덤박스생성"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}