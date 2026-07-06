import 'package:flutter/material.dart';
import 'DB.dart';

void main() {
  runApp(
    const MaterialApp(
      home: UserList(),
    ),
  );
}

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  // DB에서 가져온 사용자 목록 저장
  List<Map<String, dynamic>> list = [];

  // DB 사용자 목록 조회
  Future<void> _selectUserList() async {
    var tempList = await DB.selectUserList();

    setState(() {
      list = tempList;
    });
  }

  // 화면이 처음 실행될 때 한 번 호출
  @override
  void initState() {
    super.initState();
    _selectUserList();
  }

  @override
  Widget build(BuildContext context) {
    print(list[1]["name"]);

    return Scaffold(
      appBar: AppBar(
        title: const Text("사용자 목록"),
      ),
body:ListView.builder(
itemCount: 3,
itemBuilder: (context, index) {
  return ListTile(
    leading:Icon(Icons.home),
    title:Text("집 고고"),
    subtitle: Text("고고"),
    trailing: Row(
      children: [
        Icon(Icons.edit),
        Icon(Icons.delete)

],
),

);
},

)

    );
  }


