import 'package:audioplayers/audioplayers.dart';
import 'package:flashcard_learning/domain/models/Word.dart';
import 'package:flashcard_learning/domain/models/WordFromAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({super.key, required this.word});

  final WordFromAPI word;

  // SearchResultViewModel searchResultViewModel = SearchResultViewModel();

  Padding _buildText(String text, TextStyle? style) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        textAlign: TextAlign.left,
        text,
        style: style,
      ),
    );
  }

  TextStyle mainWord = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAudioFromNetWork(String url) async {
    print(url);

    await audioPlayer.play(UrlSource(url));
  }

  TextStyle submain = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  var apiStyle = GoogleFonts.charisSil(
    textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
  );

  var contentStyle = TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.navigate_before, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          "Dictionary",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF62F576), Color(0xFF1A6724)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
        shadowColor: Colors.black45,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText(word.word.toUpperCase(), mainWord),
                  Text(word.phonetics, style: apiStyle),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await playAudioFromNetWork(word.linkAudio);
                        },
                        icon: Icon(
                          CupertinoIcons.volume_down,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        CupertinoIcons.slowmo,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, i) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildText("Definition", submain),
                            Text(
                              word.meanings[i].definition,
                              style: contentStyle,
                            ),
                            _buildText("Example", submain),
                            Text(
                              word.meanings[i].example,
                              style: contentStyle,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final Uri url = Uri.parse(
                            "https://youglish.com/pronounce/${word.word}/english");

                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: Text(
                        "Xem người khác thực hành >",
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
