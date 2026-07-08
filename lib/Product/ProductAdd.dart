// ======================================================
// Firestore 데이터베이스를 사용하기 위한 패키지
// ======================================================
import 'package:cloud_firestore/cloud_firestore.dart';


// ======================================================
// Flutter 화면(UI)을 만들기 위한 기본 패키지
// ======================================================
import 'package:flutter/material.dart';


// ======================================================
// Firebase를 Flutter 앱에서 사용하기 위한 패키지
// ======================================================
import 'package:firebase_core/firebase_core.dart';


// ======================================================
// Firebase 프로젝트 설정 파일
//
// Android, Web, iOS 등
// 현재 실행 환경에 맞는 Firebase 설정 정보가 들어 있음
// ======================================================
import '../firebase_options.dart';



// ======================================================
// 프로그램 시작 부분
// ======================================================
void main() async {

  // Flutter 기능을 사용하기 전에 초기화
  //
  // Firebase 초기화처럼 await를 사용하는 작업을
  // runApp() 전에 실행하려면 필요함
  WidgetsFlutterBinding.ensureInitialized();


  // Firebase 초기화 및 연결
  await Firebase.initializeApp(

    // 현재 실행 중인 플랫폼에 맞는 Firebase 설정 사용
    //
    // 예)
    // Android → Android Firebase 설정
    // Web     → Web Firebase 설정
    // iOS     → iOS Firebase 설정
    options: DefaultFirebaseOptions.currentPlatform,
  );


  // Firebase 연결이 끝난 후 앱 실행
  runApp(const MyApp());
}



// ======================================================
// 앱의 메인 위젯
// ======================================================
//
// StatefulWidget 사용 이유:
//
// 현재 화면에서는
// 입력창의 데이터를 관리하고
// Firestore의 데이터를 실시간으로 출력하기 때문에
// 상태 변경이 가능한 StatefulWidget을 사용
// ======================================================
class MyApp extends StatefulWidget {

  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}



// ======================================================
// MyApp 화면의 실제 기능과 UI를 작성하는 클래스
// ======================================================
class _MyAppState extends State<MyApp> {


  // ====================================================
  // Firestore 객체 생성
  // ====================================================
  //
  // fs를 이용해서 Firestore DB에 접근할 수 있음
  //
  // 예)
  //
  // fs.collection("product")
  //
  // → product 컬렉션에 접근
  FirebaseFirestore fs = FirebaseFirestore.instance;



  // ====================================================
  // TextEditingController
  // ====================================================
  //
  // TextField에 사용자가 입력한 값을 가져오기 위해 사용
  //
  // 예)
  //
  // productName.text
  //
  // → 상품명 입력창에 입력된 글자를 가져옴


  // 상품명 입력값 관리
  TextEditingController productName =
  TextEditingController();


  // 카테고리 입력값 관리
  TextEditingController category =
  TextEditingController();


  // 가격 입력값 관리
  TextEditingController price =
  TextEditingController();


  // 상품 설명 입력값 관리
  TextEditingController info =
  TextEditingController();



  // ====================================================
  // 상품 등록 함수
  // ====================================================
  //
  // Future<void>
  //
  // Firestore 저장 작업은 시간이 걸리는 비동기 작업이므로
  // Future를 사용함
  //
  // async
  //
  // 함수 안에서 await를 사용할 수 있게 해줌
  // ====================================================
  Future<void> productAdd() async {


    // ==================================================
    // Firestore에 저장할 데이터 만들기
    // ==================================================
    //
    // Map 구조
    //
    // Key : Value
    //
    // 예)
    //
    // productName : 아이폰
    // category    : 전자제품
    // price       : 1000000
    // info        : 스마트폰입니다
    //
    // Firestore에서는 Map 형태의 데이터를 저장할 수 있음

    Map<String, dynamic> product = {


      // 상품명 입력창에 입력한 값
      //
      // 예)
      // 사용자가 "노트북" 입력
      //
      // productName.text → "노트북"
      "productName": productName.text,


      // 카테고리 입력창 값
      "category": category.text,


      // 가격 입력창 값
      //
      // TextField에서 가져온 값은 무조건 String(문자열)
      //
      // 예)
      //
      // price.text
      // "10000"
      //
      // int.parse()
      // 문자열을 정수로 변환
      //
      // "10000" → 10000
      //
      // 주의:
      // test 같은 문자를 입력하면 int.parse()에서 오류 발생
      "price": int.parse(price.text),


      // 상품 설명 입력창 값
      "info": info.text,


      // 현재 시간을 Firestore Timestamp 형식으로 저장
      //
      // 예)
      // 상품이 언제 등록되었는지 저장할 때 사용
      "cdate": Timestamp.now(),
    };



    // ==================================================
    // Firestore에 상품 저장
    // ==================================================
    //
    // fs
    // → Firestore DB
    //
    // collection("product")
    // → product 컬렉션 선택
    //
    // add(product)
    // → 위에서 만든 product Map 데이터를 저장
    //
    // add()를 사용하면 문서 ID는 자동 생성됨

    await fs
        .collection("product")
        .add(product);



    // ==================================================
    // 저장 성공 후 입력창 초기화
    // ==================================================


    // 상품명 입력창 비우기
    productName.clear();


    // 카테고리 입력창 비우기
    category.clear();


    // 가격 입력창 비우기
    price.clear();


    // 상품 설명 입력창 비우기
    info.clear();



    // 콘솔에 저장 완료 메시지 출력
    print("상품 저장 완료");
  }



  // ====================================================
  // 상품 목록 출력 함수
  // ====================================================
  //
  // 반환형이 Widget인 이유:
  //
  // 이 함수는 Firestore의 상품 데이터를 가져와서
  // ListView 화면을 만들어 반환하기 때문
  // ====================================================
  Widget getProductList() {


    // ==================================================
    // StreamBuilder
    // ==================================================
    //
    // Firestore 데이터 변경을 실시간으로 감지하는 위젯
    //
    // product 컬렉션에
    // 추가 / 수정 / 삭제가 발생하면
    // 화면이 자동으로 다시 만들어짐

    return StreamBuilder<QuerySnapshot>(


      // =================================================
      // product 컬렉션 실시간 감시
      // =================================================
      //
      // snapshots()
      //
      // 데이터가 변경될 때마다 새로운 데이터를 가져옴

      stream: fs
          .collection("product")
          .snapshots(),


      // 데이터 상태에 따라서 화면을 만들어주는 부분
      builder: (context, snapshot) {


        // ===============================================
        // 아직 데이터를 가져오지 못한 경우
        // ===============================================
        if (!snapshot.hasData) {

          // 로딩 표시
          return const Center(
            child: CircularProgressIndicator(),
          );
        }



        // ===============================================
        // Firestore 문서 목록 가져오기
        // ===============================================
        //
        // snapshot.data
        // → Firestore 조회 결과
        //
        // docs
        // → 조회 결과에 들어있는 문서 목록

        final docs = snapshot.data!.docs;



        // ===============================================
        // 상품 목록 출력
        // ===============================================
        return ListView(


          // docs의 각 문서를 하나씩 ListTile로 변환
          children: docs.map((doc) {


            // 상품 하나를 ListTile 형태로 출력
            return ListTile(


              // 왼쪽 상품 아이콘
              leading: const Icon(
                Icons.shopping_bag,
              ),


              // 상품명과 가격 출력
              //
              // 예)
              //
              // 노트북 / 1500000원
              title: Text(
                "${doc["productName"]} / ${doc["price"]}원",
              ),


              // 카테고리와 상품 설명 출력
              //
              // \n
              // → 줄바꿈
              //
              // 예)
              //
              // 카테고리: 전자제품
              // 설명: 최신 노트북입니다
              subtitle: Text(
                "카테고리: ${doc["category"]}\n"
                    "설명: ${doc["info"]}",
              ),
            );


            // map() 결과를 List로 변환
          }).toList(),
        );
      },
    );
  }



  // ====================================================
  // 화면 UI 구성
  // ====================================================
  @override
  Widget build(BuildContext context) {


    return MaterialApp(


      // 오른쪽 위 DEBUG 표시 제거
      debugShowCheckedModeBanner: false,


      // 앱의 첫 화면
      home: Scaffold(


        // ===============================================
        // 상단 AppBar
        // ===============================================
        appBar: AppBar(


          // AppBar 제목
          title: const Text(
            "제품등록",
          ),


          // AppBar 배경색
          backgroundColor: Colors.pink,
        ),



        // ===============================================
        // 화면 본문
        // ===============================================
        body: Padding(


          // 화면 전체 안쪽 여백 20
          padding: const EdgeInsets.all(20),


          // 위젯을 세로 방향으로 배치
          child: Column(


            children: [


              // =========================================
              // 화면 제목
              // =========================================
              const Text(
                "제품정보",
              ),



              // =========================================
              // 상품명 입력창
              // =========================================
              TextField(


                // 입력창과 productName 컨트롤러 연결
                controller: productName,


                decoration: const InputDecoration(


                  // 입력창 설명
                  labelText: "상품명",


                  // 입력창 테두리
                  border: OutlineInputBorder(),
                ),
              ),



              // 위젯 사이 세로 간격
              const SizedBox(
                height: 10,
              ),



              // =========================================
              // 카테고리 입력창
              // =========================================
              TextField(


                // category 컨트롤러와 연결
                controller: category,


                decoration: const InputDecoration(

                  labelText: "카테고리",

                  border: OutlineInputBorder(),
                ),
              ),



              const SizedBox(
                height: 10,
              ),



              // =========================================
              // 가격 입력창
              // =========================================
              TextField(


                // price 컨트롤러와 연결
                controller: price,


                // 숫자 입력용 키보드 표시
                //
                // 단, 이것만으로 숫자 이외의 입력을
                // 완전히 막아주는 것은 아님
                keyboardType: TextInputType.number,


                decoration: const InputDecoration(

                  labelText: "가격",

                  border: OutlineInputBorder(),
                ),
              ),



              const SizedBox(
                height: 10,
              ),



              // =========================================
              // 상품 설명 입력창
              // =========================================
              TextField(


                // info 컨트롤러와 연결
                controller: info,


                // 입력창을 4줄 크기로 표시
                maxLines: 4,


                decoration: const InputDecoration(

                  labelText: "상품 설명",

                  border: OutlineInputBorder(),
                ),
              ),



              const SizedBox(
                height: 10,
              ),



              // =========================================
              // 저장 버튼
              // =========================================
              ElevatedButton(


                // 버튼을 클릭하면
                // productAdd 함수 실행
                //
                // 아래와 같은 의미
                //
                // onPressed: () {
                //   productAdd();
                // }

                onPressed: productAdd,


                child: const Text(
                  "저장",
                ),
              ),



              // =========================================
              // 입력 부분과 목록 부분 구분선
              // =========================================
              const Divider(
                height: 30,
              ),



              // =========================================
              // 상품 목록 출력
              // =========================================
              //
              // Column 안에서 ListView를 바로 사용하면
              // 높이 오류가 발생할 수 있음
              //
              // Expanded를 사용해서
              // 남은 화면 공간을 ListView가 사용하도록 함

              Expanded(

                // Firestore 상품 목록 출력
                child: getProductList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}