import 'package:flashcard_learning/routing/router.dart';
import 'package:flashcard_learning/ui/dictionary/view_model/DictionaryViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

    DictionaryViewModel dictionaryViewModel =
        Provider.of<DictionaryViewModel>(context, listen: false);
    LoadingOverlay.show(context);
    Word word = await dictionaryViewModel.getWord(text);
    LoadingOverlay.hide();
    if (mounted) {
      SearchByMediaOverlay.hide();
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

  TextStyle wordStyle = TextStyle(
    fontSize: 20,
    decoration: TextDecoration.none,
    color: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => SearchByMediaOverlay.hide(),
      child: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(
                          colors: [Color(0xffB584E8), Color(0xff2575fc)],
                        )),
                    child: IconTheme(
                        data: IconThemeData(size: 35, color: Colors.white),
                        child: Icon(Icons.navigate_before))),
                onTap: () => SearchByMediaOverlay.hide(),
              ),
            ),
            Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _lastWord.isEmpty
                    ? Text(
                        "Please speak out loud",
                        style: hintStyle,
                      )
                    : Text(
                        _lastWord,
                        style: wordStyle,
                      )),
            _lastWord.isEmpty
                ? SizedBox.shrink()
                : Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Correction:  $_confidence",
                      style: wordStyle,
                    )),
            GestureDetector(
              onTap: () async {
                gotoSearchPage(_lastWord);
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(vertical: 16),
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Search",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
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
    );
  }
}
