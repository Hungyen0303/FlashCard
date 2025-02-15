import 'package:flashcard_learning/color/AllColor.dart';
import 'package:flashcard_learning/pages/SearchResultPage.dart';
import 'package:flashcard_learning/widgets/BoxText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dictionarypage extends StatefulWidget {
  const Dictionarypage({super.key});

  @override
  State<Dictionarypage> createState() => _DictionarypageState();
}

class _DictionarypageState extends State<Dictionarypage> {
  final TextEditingController _searchController = TextEditingController();

  TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Color(0xffdb0d46),
    fontSize: 20,
  );
  bool isSearch = false;

  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min, // Để Row chỉ chiếm không gian vừa đủ
        children: [
          Icon(Icons.book, color: MAIN_THEME_PINK_TEXT, size: 30),
          SizedBox(width: 10),
          Text(
            "Dictionary",
            style: GoogleFonts.poppins(
              color: MAIN_THEME_PINK_TEXT,
              fontSize: 28,
              fontWeight: FontWeight.w400,
              shadows: [
                Shadow(
                  // Hiệu ứng bóng
                  color: Colors.black38,
                  offset: Offset(2, 2),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ],
      ),
      leading: SizedBox.shrink(),
      centerTitle: true,
      // Căn giữa tiêu đề
      backgroundColor: MAIN_THEME_PINK,
      // Màu nền AppBar
      elevation: 6,
      // Hiệu ứng độ nổi của AppBar
      shape: const RoundedRectangleBorder(
        // Bo góc phía dưới AppBar
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
    );
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
                // if (isSearch)
                //   SizedBox(
                //     width: double.infinity,
                //     //height: double.infinity,
                //     child: Container(
                //       width: 100,
                //       height: 100,
                //       color: Colors.black.withOpacity(0.5),
                //     ),
                //   ),
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
                      color: MAIN_THEME_PINK_TEXT,
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
                      color: MAIN_THEME_PINK_TEXT,
                      size: 30.0,
                    ),
                  ),
                  hintText: "Nhập cụm từ mà bạn muốn tìm kiếm",
                  hintStyle: WidgetStateProperty.all(
                    TextStyle(
                      color: MAIN_THEME_PINK_TEXT,
                      fontSize: 16.0,
                    ),
                  ),
                  textStyle: WidgetStateProperty.all(
                    TextStyle(
                      color: MAIN_THEME_PINK_TEXT,
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
                SizedBox(height: 10,),
                Center(
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
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
                                        color: MAIN_THEME_PINK_TEXT,
                                      ),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                              onPressed: () {
                                gotoSearchPage(_searchController.text);
                              },
                              child: Text("Tra cứu", style: TextStyle(
                                fontSize: 20,
                              ),)),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 180,
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [
                                Color(0xff2196f3), // Xanh dương sáng
                                Color(0xff9c27b0), // Tím nhạt
                              ], begin: Alignment.topCenter,
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
                    Container(
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
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  style: titleStyle,
                  "Những từ tìm kiếm phổ biến ",
                ),
                SizedBox(height: 10,),
                Boxtext(word: "Cleaning the house", ontap: () {}),
                Boxtext(word: "Refresh ", ontap: () {}),
                Boxtext(word: "Putting up decoration ", ontap: () {}),
                Boxtext(word: "Putting up decoration ", ontap: () {}),
              ],
            ),
          ),
        ));
  }

  void gotoSearchPage(String text) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => Searchresultpage(text: "Hello"))) ;
  }
}
