

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      print("Vị trí cuộn: ${_scrollController.offset}");
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print("Cuộn tới cuối danh sách!");
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Giải phóng bộ nhớ
    super.dispose();
  }
  void _scrollToTop() {
    _scrollController.animateTo(
      0.0, // Cuộn lên đầu
      duration: Duration(milliseconds: 5000),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, // Cuộn xuống cuối
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        child: Icon(Icons.arrow_upward),
      ),
      appBar: AppBar(title: Text("ScrollController Demo")),
      body: Center(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.blueAccent, // Nền màu xanh
            borderRadius: BorderRadius.circular(20), // Bo tròn góc
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 2),
              ),
            ],
          ),
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient( // Tạo gradient cho foreground
              colors: [Colors.white.withOpacity(0.2), Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20), // Bo tròn giống như decoration
          ),
          child: Center(
            child: Text(
              'Combination',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
