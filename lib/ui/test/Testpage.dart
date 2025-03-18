import 'dart:typed_data';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Api1Impl.dart';
import 'package:flashcard_learning/domain/models/user.dart';
import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/services/supabass_service/SupabassService.dart';

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

  String API_KEY = "AIzaSyBax0qdrfE8U0TzsW4OISS4VZ3DqLic20s";
  TextEditingController textEditingController = TextEditingController();
  String res = " ";
  String imagePath = "" ;
  Future<String> uploadImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

    return await SupaBaseService.uploadImageToSupabase(image!.path, image!.name);

  }

  Api1 api = Api1Impl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AI generative "),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: TextField(
                      controller: textEditingController,
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        final model = GenerativeModel(
                          model: 'gemini-1.5-flash-latest',
                          apiKey: API_KEY,
                        );

                        final content = [
                          Content.text(textEditingController.text)
                        ];
                        final response = await model.generateContent(content);

                        setState(() {
                          res = response.text ?? "";
                        });
                        print(response.text);
                      },
                      icon: Icon(Icons.send_sharp)),
                ],
              ),
              Text("Response: \n $res"),
              ElevatedButton(
                onPressed: () async {

                  imagePath = await uploadImage();
                  setState(() {});
                },
                child: Text("Get images "),
              ),
              imagePath.isNotEmpty
                  ? Image.network(imagePath)
                  : SizedBox.shrink()
            ],
          ),
        ));
  }
}
