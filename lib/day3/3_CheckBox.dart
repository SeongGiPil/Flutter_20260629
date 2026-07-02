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

// 화면의 상태를 관리하는 클래스
class _MyAppState extends State<MyApp> {

  // 체크된 이미지 파일명을 저장하는 리스트
  List<String> checkList = [];

  // 사용할 이미지 파일명 리스트
  List<String> imgList = [
    "img1.png",
    "img2.png",
    "img3.png"
  ];

  // 체크박스 상태 변경 메서드
  void listChange(String item, bool flg) {

    // 화면 다시 그리기
    setState(() {

      // 체크되었으면 리스트에 추가
      if (flg) {
        checkList.add(item);

        // 체크 해제되었으면 리스트에서 제거
      } else {
        checkList.remove(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        // 화면 구성
        body: Column(
          children: [

            // 체크박스 영역
            Column(
              children: [

                // 첫 번째 체크박스
                CheckboxListTile(

                  // img1이 리스트에 있으면 체크
                  value: checkList.contains(imgList[0]),

                  // 체크박스를 왼쪽에 배치
                  controlAffinity: ListTileControlAffinity.leading,

                  // 체크박스 제목
                  title: Text("망곰1"),

                  // 체크 상태 변경 시 실행
                  onChanged: (value) {
                    listChange(imgList[0], value!);
                  },
                ),

                // 두 번째 체크박스
                CheckboxListTile(
                  value: checkList.contains(imgList[1]),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("망곰2"),
                  onChanged: (value) {
                    listChange(imgList[1], value!);
                  },
                ),

                // 세 번째 체크박스
                CheckboxListTile(
                  value: checkList.contains(imgList[2]),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("망곰3"),
                  onChanged: (value) {
                    listChange(imgList[2], value!);
                  },
                ),
              ],
            ),

            // 남은 공간을 GridView가 사용
            Expanded(

              // 선택된 이미지를 Grid 형태로 출력
              child: GridView.builder(

                // 한 줄에 이미지 3개 배치
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,

                  // 세로 간격
                  mainAxisSpacing: 10,

                  // 가로 간격
                  crossAxisSpacing: 10,
                ),

                // 선택된 이미지 개수만큼 출력
                itemCount: checkList.length,

                // 이미지 생성
                itemBuilder: (context, index) {

                  // checkList에 저장된 이미지 파일 출력
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