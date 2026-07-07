import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> getDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'memo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE TBL_MEMO (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            date TEXT
          )
        ''');
      },
    );
  }

  // 메모 저장
  static Future<void> insertMemo(
      String title,
      String content,
      ) async {
    final db = await getDatabase();

    await db.insert(
      "TBL_MEMO",
      {
        "title": title,
        "content": content,

      },
    );
  }

  // 메모 전체 조회
  static Future<List<Map<String, dynamic>>> selectMemoList() async {
    final db = await getDatabase();

    return await db.query(
      "TBL_MEMO",
      orderBy: "id DESC",
    );
  }
  static Future<void> deleteMemo(int userId) async{
    final db = await getDatabase();
    await db.delete("TBL_Memo", where: "userId = ?", whereArgs: [userId]);
  }

  static Future<void> updateUser(String name, int age, int userId) async{
    final db = await getDatabase();
    await db.update("TBL_USER",
        {'name' : name, 'age' : age},
        where: "userId = ?",
        whereArgs: [userId]);
  }
}