import 'package:flashcard_learning/widgets/BoxText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Dictionarypage extends StatefulWidget {
  const Dictionarypage({super.key});

  @override
  State<Dictionarypage> createState() => _DictionarypageState();
}

class _DictionarypageState extends State<Dictionarypage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dictionary"),
          centerTitle: true,
          leading: SizedBox.shrink(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Bạn muốn tìm gì ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
                SearchBar(
                  controller: _searchController,
                  leading: Icon(LineIcons.search),
                  hintText: "Nhập cụm từ mà bạn muốn tìm kiếm ",
                ),
                Center(
                  child: Visibility(
            
            
            
                      child: ElevatedButton(
            
                          style: ElevatedButton.styleFrom(
            
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          onPressed: () {
                            gotoSearchPage(_searchController.text);
                          },
                          child: Text("Tra cứu"))),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 180,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.blueAccent],
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
                                fontSize: 25,
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
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.blueAccent],
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
                                fontSize: 30,
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
                Text(
                  "Những từ tìm kiếm phổ biến ",
                ),
                Boxtext(word: "Cleaning the house", ontap: () {}),
                Boxtext(word: "Refresh ", ontap: () {}),
                Boxtext(word: "Putting up decoration ", ontap: () {}),
                Boxtext(word: "Putting up decoration ", ontap: () {}),
              ],
            ),
          ),
        ));
  }

  void gotoSearchPage(String text) {}
}
