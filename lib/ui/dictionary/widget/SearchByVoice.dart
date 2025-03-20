import 'package:flashcard_learning/domain/models/WordFromAPI.dart';
import 'package:flashcard_learning/routing/router.dart';
import 'package:flashcard_learning/ui/dictionary/view_model/DictionaryViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../domain/models/Word.dart';
import '../../../utils/LoadingOverlay.dart';
import '../../search_result/searchResult_screen.dart';
import 'SearchByVoiceOverlay.dart';

class SearchByVoice extends StatefulWidget {
  const SearchByVoice({super.key});

  @override
  State<SearchByVoice> createState() => SearchByVoiceState();
}

class SearchByVoiceState extends State<SearchByVoice> {
  String _lastWord = "";
  String _confidence = "0";
  SpeechToText speechToText = SpeechToText();

  void onResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWord = result.recognizedWords;
      _confidence = (result.confidence * 100).ceil().toString();
    });
  }

  void stopListen() async {
    await speechToText.stop();
    setState(() {});
  }

  void startListen() async {
    await speechToText.listen(onResult: onResult);
    setState(() {});
  }

  @override
  void initState() {
    speechToText.initialize();
    setState(() {});
  }

  Future<void> gotoSearchPage(String text) async {
    if (text.isEmpty) return;

    LoadingOverlay.show(context);
    WordFromAPI wordFromAPI =
        await Provider.of<DictionaryViewModel>(context, listen: false)
            .loadWord(text);
    LoadingOverlay.hide();
    if (mounted) {
      SearchByMediaOverlay.hide();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => SearchResultPage(
                word: wordFromAPI,
              )));
    }
  }

  TextStyle hintStyle = TextStyle(
    fontFamily: "MainFont",
    fontWeight: FontWeight.w100,
    fontSize: 20,
    color: Color(0xFF187EE1),
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
  );

  TextStyle wordStyle = TextStyle(
    fontSize: 20,
    decoration: TextDecoration.none,
    color: Color(0xFF09A423),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: () {
          SearchByMediaOverlay.hide(); // Ẩn overlay khi nhấn vào lớp phủ
        },
        child: Container(
          color: Colors.black.withOpacity(0.5), // Nền mờ
          width: double.infinity,
          height: double.infinity, // Đảm bảo phủ toàn màn hình
        ),
      ),
      SafeArea(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 50, bottom: 20 , left: 20 ,right: 20),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: _lastWord.isEmpty
                    ? Text(
                        "Please press micro and  speak out loud",
                        style: hintStyle,
                      )
                    : Text(
                        _lastWord,
                        style: hintStyle,
                      )),
            _lastWord.isEmpty
                ? SizedBox.shrink()
                : Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Correction:  $_confidence",
                      style: wordStyle,
                    )),
            _lastWord.isNotEmpty
                ? GestureDetector(
                    onTap: () async {
                      gotoSearchPage(_lastWord);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        gradient:LinearGradient(colors: [
                          Color(0xFFE86902) ,
                          Color(0xFFFAD14C) ,

                        ]),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7)),
                      child: Text(
                        "Search",
                        style: TextStyle(
                            color:  Color(0xFFFFFFFF),
                            fontSize: 20,
                            fontFamily: "mainFont",
                            decoration: TextDecoration.none),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: speechToText.isListening ? stopListen : startListen,
                  child: Container(
                      padding: EdgeInsets.all(24.0),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(
                            colors: [Color(0xffB584E8), Color(0xff2575fc)],
                          )),
                      child: IconTheme(
                          data: IconThemeData(size: 35, color: Colors.white),
                          child: speechToText.isListening
                              ? Icon(Icons.mic_off)
                              : Icon(Icons.mic))),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
