import 'package:flutter/material.dart';
import 'DB.dart';
void main() {
  runApp(
    const MaterialApp(
      home: UserInsert(),
    ),
  );
}

class UserInsert extends StatefulWidget {
  const UserInsert({super.key});

  @override
  State<UserInsert> createState() => _UserInsertState();
}

class _UserInsertState extends State<UserInsert> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sqflite 실습"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)=> UserList(),

                  )
              )
              // 목록 페이지 이동 기능 나중에 작성
            },
            icon: const Icon(Icons.list),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                label: Text("이름"),
              ),
            ),
            TextField(
              controller: ageCtrl,
              decoration: const InputDecoration(
                label: Text("나이"),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: ()  async {
                String name=nameCtrl.text;
                int age= int.tryParse(ageCtrl.text)??0;
              await  DB.insertUser(name,age);

                nameCtrl.clear();
                ageCtrl.clear();
              },
              child: const Text("추가!"),
            ),
          ],
        ),
      ),
    );
  }
}