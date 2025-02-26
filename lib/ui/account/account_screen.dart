import 'package:flashcard_learning/main.dart';
import 'package:flashcard_learning/routing/route.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flashcard_learning/ui/auth/login/widgets/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:material_symbols_icons/symbols.dart';

class AccountPage extends StatefulWidget {
  AccountPage({super.key});

  int _index = 0;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  void changeTab(int tab) {
    setState(() {
      widget._index = tab;
    });
  }

  void _Logout(BuildContext context) {
    // TODO : give token back

    context.go(AppRoute.login);
  }

  void _gotoAccountPage() {}

  Container buildActions(Icon icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xffe8a90e), borderRadius: BorderRadius.circular(10)),
      child: IconTheme(
          data: IconThemeData(
            color: Color(0xFF6200EE),
          ),
          child: icon),
    );
  }

  TextStyle textStyle = TextStyle(color: MAIN_THEME_BLUE_TEXT);
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: Colors.grey[500],
  );

  AppBar _buildAppbar() {
    return AppBar(
      leading: Icon(
        LineIcons.userShield,
        color: Color(0xFF6200EE),
      ),
      title: Text(
        "Account",
        style: TextStyle(color: MAIN_THEME_BLUE_TEXT),
      ),
      centerTitle: true,
      actions: [
        buildActions(Icon(LineIcons.lightningBolt)),
        buildActions(Icon(LineIcons.fire)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => changeTab(0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:
                              0 == widget._index ? Colors.grey : Colors.black),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Tiến độ",
                        style: TextStyle(
                          color:
                              0 == widget._index ? Colors.black : Colors.white,
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
                          color:
                              1 == widget._index ? Colors.grey : Colors.black),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Thành tựu",
                        style: TextStyle(
                          color:
                              1 == widget._index ? Colors.black : Colors.white,
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
                          color:
                              2 == widget._index ? Colors.grey : Colors.black),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Bạn bè",
                        style: TextStyle(
                          color:
                              2 == widget._index ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              /*Profile */
              const SizedBox(
                height: 15,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xffd0eff3),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: IntrinsicWidth(
                        child: Container(
                          width: 60,
                          height: 60,
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50000)),
                                  color: Colors.greenAccent),
                            ),
                            Align(
                              child: Icon(
                                LineIcons.user,
                                size: 50,
                              ),
                              alignment: Alignment.center,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5000))),
                                  child: Icon(
                                    CupertinoIcons.camera_viewfinder,
                                    size: 20,
                                  )),
                            )
                          ]),
                        ),
                      ),
                      title: Text(
                        "Người dùng khách",
                        style: TextStyle(color: MAIN_THEME_BLUE_TEXT),
                      ),
                      subtitle: GestureDetector(
                        child: Text(
                          "Chỉnh sửa hồ sơ",
                          style: TextStyle(color: MAIN_THEME_BLUE_TEXT),
                        ),
                        onTap: () {
                          _gotoAccountPage();
                        },
                      ),
                      trailing: Icon(Icons.navigate_next),
                    ),
                    Divider(
                      height: 2,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(text: "Trạng thái\n", style: textStyle),
                          TextSpan(
                              text: "Miễn phí",
                              style: textStyle.copyWith(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ])),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent,
                            ),
                            onPressed: () {},
                            child: Text(
                              "Nâng cấp",
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xffd0eff3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Hoạt động",
                      style: textStyle.copyWith(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Theo dõi tiến độ học nào",
                      style: textStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: boxDecoration,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text("7 ngày qua"),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: boxDecoration,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text("1 tháng qua"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 150,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          width: 180,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff2196f3), // Xanh dương sáng
                                    Color(0xff9c27b0), // Tím nhạt
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.book_sharp,
                                color: Colors.white,
                                size: 25,
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              Text(
                                "BÀI HỌC ĐÃ HOÀN THÀNH",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.lock_clock,
                                color: Colors.white,
                                size: 25,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                "0",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              Text(
                                "PHÚT ĐÃ LUYỆN TẬP",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xfffe3030),
                    ),
                    onPressed: () {
                      _Logout(context);
                    },
                    child: Text(
                      "Đăng xuất",
                      style: textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xffffffff)),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
