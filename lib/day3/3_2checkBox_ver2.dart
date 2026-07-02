import 'package:flutter/material.dart';

// 프로그램 시작
void main() {
  // MyApp 실행
  runApp(const MyApp());
}

// StatefulWidget 생성
// 체크박스를 선택할 때마다 화면이 변경되므로 StatefulWidget 사용
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// 상태를 관리하는 클래스
class _MyAppState extends State<MyApp> {

  // 체크된 이미지 파일명을 저장하는 리스트
  List<String> checkList = [];

  // 사용할 이미지 파일명 목록
  List<String> imgList = [
    "img1.png",
    "img2.png",
    "img3.png"
  ];

  // 체크박스 상태가 변경될 때 실행되는 메서드
  void listChange(String item, bool flg) {

    // 화면을 다시 그리기 위해 setState 사용
    setState(() {

      // 체크되면 리스트에 추가
      if (flg) {
        checkList.add(item);

        // 체크 해제되면 리스트에서 제거
      } else {
        checkList.remove(item);
      }
    });
  }

  // 체크박스를 생성하는 사용자 정의 위젯(메서드)
  Widget MyCheckBox(String title, {required String imgUrl}) {

    return CheckboxListTile(

      // 체크박스를 왼쪽에 배치
      controlAffinity: ListTileControlAffinity.leading,

      // 체크박스 제목
      title: Text(title),

      // imgUrl이 checkList에 있으면 체크 상태
      value: checkList.contains(imgUrl),

      // 체크 상태가 변경되면 listChange 호출
      onChanged: (value) {
        listChange(imgUrl, value!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        // 화면 구성
        body: Column(
          children: [

            // 체크박스들을 세로로 배치
            Column(
              children: [

                // 첫 번째 체크박스
                MyCheckBox(
                  "망곰1",
                  imgUrl: imgList[0],
                ),

                // 두 번째 체크박스
                MyCheckBox(
                  "망곰2",
                  imgUrl: imgList[1],
                ),

                // 세 번째 체크박스
                MyCheckBox(
                  "망곰3",
                  imgUrl: imgList[2],
                ),
              ],
            ),

            // 남은 공간을 GridView가 차지
            Expanded(

              // 선택된 이미지를 Grid 형태로 출력
              child: GridView.builder(

                // Grid 설정
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                  // 한 줄에 이미지 3개
                  crossAxisCount: 3,

                  // 세로 간격
                  mainAxisSpacing: 10,

                  // 가로 간격
                  crossAxisSpacing: 10,
                ),

                // 선택된 이미지 개수만큼 생성
                itemCount: checkList.length,

                // 이미지 생성
                itemBuilder: (context, index) {

                  // checkList에 저장된 이미지 출력
                  return Image.asset(checkList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}