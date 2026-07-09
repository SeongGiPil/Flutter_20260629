import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ProductList.dart';

class EditProduct extends StatefulWidget {
  final String docId;

  const EditProduct({super.key, required this.docId});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final FirebaseFirestore fs = FirebaseFirestore.instance;

  final productName = TextEditingController();
  final category = TextEditingController();
  final price = TextEditingController();
  final info = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProductData();
  }

  Future<void> loadProductData() async {
    final doc = await fs.collection("Product").doc(widget.docId).get();

    if (doc.exists) {
      final data = doc.data()!;

      setState(() {
        productName.text = data["productName"] ?? "";
        category.text = data["category"] ?? "";
        price.text = data["price"].toString();
        info.text = data["info"] ?? "";
      });
    }
  }

  Future<void> updateProduct() async {
    await fs.collection("Product").doc(widget.docId).update({
      "productName": productName.text,
      "category": category.text,
      "price": int.parse(price.text),
      "info": info.text,
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ProductList()),
    );
  }

  @override
  void dispose() {
    productName.dispose();
    category.dispose();
    price.dispose();
    info.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('제품 수정'),
        centerTitle: true,
        backgroundColor: Colors.pink[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductList()),
              );
            },
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.blue[300],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: '등록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '마이페이지',
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              '제품 정보',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: productName,
              decoration: InputDecoration(
                labelText: '제품명',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: category,
              decoration: InputDecoration(
                labelText: '카테고리',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '가격',
                prefixText: '₩ ',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              '상세 설명',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: info,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: '제품에 대한 설명을 입력해주세요',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: updateProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '제품 수정하기',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}