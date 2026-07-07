import 'package:flutter/material.dart';
import 'MemoDB.dart';
import 'Edit.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Map<String, dynamic>> list = [];

  Future<void> _selectMemoList() async {
    var tempList = await DB.selectMemoList();
    setState(() {
      list = tempList;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectMemoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("메모 목록"),
        backgroundColor: const Color(0xFFF8BBD0),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];

          return ListTile(
            title: Text(item['title'] ?? ''),
            subtitle: Text(item['content'] ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item['date'] ?? ''),
                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MemoEdit(
                          userId: item["userId"],
                        ),
                      ),
                    );

                    _selectMemoList();
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("삭제"),
                          content: const Text("정말 삭제하시겠습니까?"),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await DB.deleteMemo(item["userId"]);
                                Navigator.of(context).pop();
                                _selectMemoList();
                              },
                              child: const Text("삭제"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("취소"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}