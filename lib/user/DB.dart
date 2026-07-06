// SQLite 데이터베이스를 Flutter에서 사용하기 위한 패키지
import 'package:sqflite/sqflite.dart';

// 데이터베이스 파일 경로를 안전하게 합치기 위한 패키지
import 'package:path/path.dart';


// 데이터베이스 관련 기능을 관리하는 클래스
class DB {


  // 데이터베이스를 생성하거나 연결하는 함수
  // Database 객체를 Future 형태로 반환
  static Future<Database> getDatabase() async {

    // 스마트폰 내부의 데이터베이스 저장 경로 가져오기
    var databasesPath = await getDatabasesPath();

    // 데이터베이스 저장 경로 + demo.db 파일명 결합
    // 예: /data/user/0/앱이름/databases/demo.db
    String path = join(databasesPath, 'demo.db');


    // demo.db 데이터베이스 열기
    // 파일이 없다면 새로 생성
    return await openDatabase(

      // 데이터베이스 파일 경로
      path,

      // 현재 데이터베이스 버전
      version: 3,


      // 데이터베이스가 처음 생성될 때 한 번 실행
      onCreate: (db, version) async {

        // 사용자 정보를 저장하는 테이블 생성
        await db.execute('''
          CREATE TABLE TBL_USER(

            -- 사용자 번호
            -- PRIMARY KEY: 기본키
            -- AUTOINCREMENT: 자동으로 1씩 증가
            userId INTEGER PRIMARY KEY AUTOINCREMENT, 

            -- 사용자 이름
            name TEXT, 

            -- 사용자 나이
            age INTEGER
          )
        ''');
      },


      // 데이터베이스 버전이 올라갔을 때 실행
      // 예: version 2 → version 3
      onUpgrade: (db, oldVersion, newVersion) async {

        // 기존 DB 버전이 3보다 작은 경우 실행
        if (oldVersion < 3) {

          // 사용자 테이블 생성
          await db.execute('''
            CREATE TABLE TBL_USER(

              // 사용자 번호 자동 증가
              userId INTEGER PRIMARY KEY AUTOINCREMENT, 

              // 사용자 이름
              name TEXT, 

              // 사용자 나이
              age INTEGER
            )
          ''');
        }
      },
    );
  }


  // 사용자 정보를 DB에 추가하는 함수
  // name과 age를 전달받음
  static Future<void> insertUser(String name, int age) async {

    // 데이터베이스 연결
    final db = await getDatabase();


    // TBL_USER 테이블에 데이터 추가
    await db.insert(
      "TBL_USER",

      // Map 형태로 컬럼과 값 전달
      {
        'name': name,
        'age': age
      },
    );
  }


  // TBL_USER의 사용자 목록을 조회하는 함수
  static Future<List<Map<String, dynamic>>> selectUserList() async {

    // 데이터베이스 연결
    final db = await getDatabase();


    // TBL_USER 테이블 전체 데이터 조회
    // SQL로 보면 SELECT * FROM TBL_USER와 동일
    return await db.query("TBL_USER");
  }
}