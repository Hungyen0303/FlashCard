import 'dart:io';

import 'package:flashcard_learning/features/share_widget.dart/loading_overlay.dart';
import 'package:flashcard_learning/core/app_colors/app_colors.dart';
import 'package:flashcard_learning/ui/search_result/searchResult_screen.dart';
import 'package:flashcard_learning/ui/dictionary/widget/BoxText.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:line_icons/line_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/Word.dart';

import '../../../domain/models/WordFromAPI.dart';
import '../../../core/routing/route.dart';
import '../view_model/DictionaryViewModel.dart';
import 'SearchByVoiceOverlay.dart';
import 'SearchByImage.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key, required this.dictionaryViewModel});

  final DictionaryViewModel dictionaryViewModel;

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> popularWords = [];

  TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.w700,
    color: Color(0xFF045FB4),
    fontSize: 20,
  );
  bool isSearch = false;
  late Future load;

  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min, // Để Row chỉ chiếm không gian vừa đủ
        children: [
          Text(
            "📖 Dictionary",
            style: GoogleFonts.poppins(
              color: MAIN_TITLE_COLOR,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  void initState() {
    super.initState();
    load = _fetchPopularWords();
  }

  Future<void> _fetchPopularWords() async {
    final words = await widget.dictionaryViewModel.getPopularWord();
    if (mounted) {
      setState(() {
        popularWords = words;
      });
    }
    print(popularWords);
  }

  Future<void> gotoSearchPage(String text) async {
    LoadingOverlay.show(context);
    WordFromAPI? wordFromAPI =
        await Provider.of<DictionaryViewModel>(context, listen: false)
            .loadWord(text);

    LoadingOverlay.hide();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SearchResultPage(
              word: wordFromAPI,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Bạn muốn tìm gì",
                    style: titleStyle,
                  ),
                ),
                SearchBar(
                  onTap: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {
                      // isSearch = false;
                    });
                  },
                  controller: _searchController,
                  elevation: WidgetStateProperty.all(3.0),
                  shadowColor: WidgetStateProperty.all(
                      MAIN_THEME_PURPLE.withOpacity(0.2)),
                  side: WidgetStateProperty.all(
                    BorderSide(
                      color: MAIN_TITLE_COLOR,
                      width: 1.2,
                    ),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 4, right: 2),
                    child: Icon(
                      LineIcons.search,
                      color: MAIN_TITLE_COLOR,
                      size: 30.0,
                    ),
                  ),
                  hintText: "Nhập cụm từ mà bạn muốn tìm kiếm",
                  hintStyle: WidgetStateProperty.all(
                    TextStyle(
                      color: MAIN_TITLE_COLOR,
                      fontSize: 16.0,
                    ),
                  ),
                  textStyle: WidgetStateProperty.all(
                    TextStyle(
                      color: MAIN_TITLE_COLOR,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 14.0),
                  ),
                  constraints: const BoxConstraints(minHeight: 56.0),
                  backgroundColor: WidgetStateProperty.all(
                    Colors.white.withOpacity(0.95),
                  ),
                  surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isSearch ? 1 : 0.2,
                    child: Visibility(
                        visible: isSearch,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: MAIN_TITLE_COLOR,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              onPressed: () async {
                                if (_searchController.text.isEmpty) {
                                  return;
                                }
                                await gotoSearchPage(_searchController.text);
                              },
                              child: Text(
                                "Tra cứu",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => SearchByMediaOverlay.show(context),
                      child: Container(
                        height: 180,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        width: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xff2196f3),
                                  Color(0xff9c27b0),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mic,
                              color: Colors.white,
                              size: 50,
                            ),
                            Text(
                              "Phát âm ",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Text(
                              "Phát âm cụm từ để kiểm tra phát âm ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        context.push(AppRoute.SearchByImagePath);
                      },
                      child: Container(
                        height: 180,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        width: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xffff6f20), // Cam nhạt
                                  Color(0xffe91e63), // Hồng đậm
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.white,
                              size: 50,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "Tìm bằng hình ảnh ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Text(
                              "Phát âm cụm từ để kiểm tra phát âm ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  style: titleStyle,
                  "Những từ tìm kiếm phổ biến ",
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: popularWords
                      .map((word) => Boxtext(
                          word: word,
                          onTap: () async {
                            gotoSearchPage(word);
                          }))
                      .toList(),
                )
              ],
            ),
          ),
        ));
  }
}
