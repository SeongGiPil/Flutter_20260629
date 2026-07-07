import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late final SlidableController controller = SlidableController(this);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Slidable 예제"),
        ),
        body: ListView(
          children: [
            Slidable(
              key: const ValueKey(0),
              controller: controller,

              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () {},
                ),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      print("삭제");
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: "Delete",
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      print("공유");
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.share,
                    label: "Share",
                  ),
                ],
              ),

              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text("홍길동"),
                subtitle: Text("20살"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}