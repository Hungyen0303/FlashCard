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

  late Future<void> chooseImage;

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
  void initState() {
    super.initState();
    chooseImage = _pickImage();
  }

  Future<void> gotoSearchPage(String text) async {
    DictionaryViewModel dictionaryViewModel =
        Provider.of<DictionaryViewModel>(context, listen: false);
    LoadingOverlay.show(context);
    Word word = await dictionaryViewModel.getWord(text);
    LoadingOverlay.hide();
    if (mounted) {
      context.pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => Searchresultpage(
                word: word,
              )));
    }
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
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.navigate_before,
                  color: Colors.blue,
                ),
                onPressed: () => context.pop(),
              ),
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.blue,
                fontSize: 25,
              ),
              title: Text("Text regconition"),
            ),
            floatingActionButton: FloatingActionButton(
              foregroundColor: Colors.blue,
              backgroundColor: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black26, width: 1)),
              onPressed: _pickImage,
              child: const Icon(CupertinoIcons.plus),
            ),
            body: path.isEmpty
                ? const Center(
                    child: Text(
                      "Press + to add image",
                      style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        color: Colors.blue,
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: Image.file(File(path))),
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
                          GestureDetector(
                            onTap: () {
                              gotoSearchPage(textRecognized);
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xffb584e8),
                                          Color(0xff8518de)
                                        ])),
                                child: Text(
                                  "Search",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
          );
        });
  }
}
