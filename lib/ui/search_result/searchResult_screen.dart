import 'package:audioplayers/audioplayers.dart';
import 'package:flashcard_learning/domain/models/Word.dart';
import 'package:flashcard_learning/domain/models/WordFromAPI.dart';
import 'package:flashcard_learning/l10n/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({super.key, required this.word});

  final WordFromAPI? word;
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

  Widget _buildUnfoundWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.sr_not_found_title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              context.l10n.sr_not_found_desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.search),
            label: Text(context.l10n.sr_search_again),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
          context.l10n.sr_dictionary_title,
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
      body: word == null
          ? _buildUnfoundWidget(context)
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildText(word!.word.toUpperCase(), mainWord),
                        Text(word!.phonetics, style: apiStyle),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await playAudioFromNetWork(word!.linkAudio);
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
                                  _buildText(
                                      context.l10n.sr_definition, submain),
                                  Text(
                                    word!.meanings.isNotEmpty
                                        ? word!.meanings[i].definition
                                        : context.l10n.sr_no_meaning,
                                    style: contentStyle,
                                  ),
                                  _buildText(context.l10n.sr_example, submain),
                                  Text(
                                    word!.meanings.isNotEmpty
                                        ? word!.meanings[i].example
                                        : context.l10n.sr_no_example,
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
                                  "https://youglish.com/pronounce/${word!.word}/english");

                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            child: Text(
                              context.l10n.sr_watch_others,
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
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
