import 'dart:io';

import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final ScrollController _scrollController = ScrollController();
  String path = "";
  String textRecognized = "";

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(() {
    //   print("Vị trí cuộn: ${_scrollController.offset}");
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     print("Cuộn tới cuối danh sách!");
    //   }
    // });
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

  Scaffold _buildScrollUI() {
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
            gradient: LinearGradient(
              // Tạo gradient cho foreground
              colors: [Colors.white.withOpacity(0.2), Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius:
                BorderRadius.circular(20), // Bo tròn giống như decoration
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

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    try {
      path = image!.path;
      final InputImage inputImage = InputImage.fromFilePath(path);
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      textRecognized = recognizedText.text;
      setState(() {});
    } catch (e) {
      print("Exception $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text regconition"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: const Icon(CupertinoIcons.plus),
      ),
      body: path.isEmpty
          ? const Center(
              child: Text("Press + to add image "),
            )
          : Column(
              children: [
                Center(child: Image.file(File(path))),
                Text(textRecognized) ,
              ],
            ),
    );
  }
}
