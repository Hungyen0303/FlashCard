import 'dart:io';

import 'package:flashcard_learning/routing/router.dart';
import 'package:flashcard_learning/ui/dictionary/view_model/DictionaryViewModel.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/Word.dart';
import '../../../domain/models/WordFromAPI.dart';
import '../../../utils/LoadingOverlay.dart';
import '../../search_result/searchResult_screen.dart';

class SearchByImage extends StatefulWidget {
  const SearchByImage({super.key});

  @override
  State<SearchByImage> createState() => SearchByImageState();
}

class SearchByImageState extends State<SearchByImage> {
  String path = "";
  String textRecognized = "";
  bool isError = false;

  String errorMessage = "";

  late Future<void> chooseImage;

  Future<void> _pickImage() async {
    isError = false;
    errorMessage = "";
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
      if (textRecognized.isEmpty) {
        isError = true;
        errorMessage = "Can not find any word";
      } else if (textRecognized.split(" ").length > 1) {
        isError = true;
        errorMessage = "Too many word , please choose another picture";
      }

      setState(() {});
    } catch (e) {
      print("Exception $e");
    }
  }

  @override
  void initState() {
    super.initState();
    chooseImage = _pickImage();
  }

  Future<void> gotoSearchPage(String text) async {
    LoadingOverlay.show(context);
    WordFromAPI wordFromAPI =
        await Provider.of<DictionaryViewModel>(context, listen: false)
            .loadWord(text);
    LoadingOverlay.hide();

    context.pop();
    // TODO Route
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SearchResultPage(
              word: wordFromAPI,
            )));
  }

  Widget _buildErrorMessage(String errorMessage) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        border: Border.all(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        errorMessage,
        style: TextStyle(color: Colors.redAccent, fontSize: 16),
      ),
    );
  }

  TextStyle hintStyle = TextStyle(
    color: Colors.grey,
    fontSize: 16,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
  );

  TextStyle recognizedTextStyle = TextStyle(
    fontSize: 20,
    decoration: TextDecoration.none,
    color: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: chooseImage,
        builder: (context, snapshot) {
          return Scaffold(
              backgroundColor: Colors.blue[50]!,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.navigate_before, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
                centerTitle: true,
                title: Text(
                  "Text Recognition",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.indigo],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                elevation: 4,
                shadowColor: Colors.black45,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: _pickImage,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.blueAccent, width: 2),
                ),
                child: Icon(CupertinoIcons.plus, color: Colors.blueAccent),
                elevation: 6,
                tooltip: "Pick an image",
              ),
              body: path.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.photo,
                            size: 80,
                            color: Colors.blueAccent.withOpacity(0.7),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Press + to add an image",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(child: Image.file(File(path))),
                          isError
                              ? _buildErrorMessage(errorMessage)
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 50,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Recognized word: ",
                                style: hintStyle,
                              ),
                              TextSpan(
                                text: textRecognized,
                                style: recognizedTextStyle,
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isError
                                  ? SizedBox.shrink()
                                  : GestureDetector(
                                      onTap: () {
                                        gotoSearchPage(textRecognized);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 80, vertical: 20),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xffb584e8),
                                                    Color(0xff8518de)
                                                  ])),
                                          child: Text(
                                            "Search",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          )),
                                    ),
                            ],
                          )
                        ],
                      ),
                    ));
        });
  }
}
