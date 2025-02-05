import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Accountpage extends StatefulWidget {
  Accountpage({super.key});

  int _index = 0;

  @override
  State<Accountpage> createState() => _AccountpageState();
}

class _AccountpageState extends State<Accountpage> {
  void changeTab(int tab) {
    setState(() {
      widget._index = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => changeTab(0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: 0 == widget._index ? Colors.grey : Colors.black),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Tiến độ",
                      style: TextStyle(
                        color: 0 == widget._index ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => changeTab(1),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: 1 == widget._index ? Colors.grey : Colors.black),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Thành tựu",
                      style: TextStyle(
                        color: 1 == widget._index ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => changeTab(2),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: 2 == widget._index ? Colors.grey : Colors.black),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Bạn bè",
                      style: TextStyle(
                        color: 2 == widget._index ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /*Profile */
            Container(
              margin: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text("Người dùng khách"),
                    subtitle: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.pending),
                            Text("Chỉnh sửa hồ sơ ")
                          ],
                        )),
                    trailing: Icon(Icons.navigate_next),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.red,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(text: "Trạng thái\n"),
                        TextSpan(text: "Miễn phí"),
                      ])),
                      ElevatedButton(onPressed: () {}, child: Text("Nâng cấp")),
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(text: "Hoạt động " , ),
                    TextSpan(
                      text: "Theo dõi tiến độ luyện tập cùng FLASHCARD",
                    )
                  ])),
                  Divider(
                    color: Colors.black,
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
