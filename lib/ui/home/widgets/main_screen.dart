import 'package:flashcard_learning/routing/route.dart';
import 'package:flashcard_learning/routing/router.dart';
import 'package:flashcard_learning/ui/account/account_viewmodel.dart';
import 'package:flashcard_learning/ui/auth/AppManager.dart';
import 'package:flashcard_learning/ui/home/view_models/MainScreenViewModel.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'AIConversation.dart';
import '../../flashcard_sets/widgets/flashcard_sets_screen.dart';

class Mainflashcard extends StatefulWidget {
  const Mainflashcard({super.key, required this.onTabChange});

  final Function onTabChange;

  @override
  State<Mainflashcard> createState() => _MainflashcardState();
}

class _MainflashcardState extends State<Mainflashcard> {
  void _gotoAllCollections(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const AllFlashCardSet()));
  }

  late Future loadData;

  Padding buildListTile(String title, Icon leadingIcon, Function callback) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        horizontalTitleGap: 30,
        splashColor: Colors.deepPurpleAccent,
        focusColor: Colors.blue,
        iconColor: Colors.red,
        tileColor: MAIN_THEME_PURPLE,
        trailing: Container(
          width: 45,
          height: 45,
          margin: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.navigate_next,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffa16eeb), Color(0xFF6200EE)]),
              color: Colors.red,
              shape: BoxShape.circle),
        ),
        onTap: () => callback(),
        leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconTheme(
              data: IconThemeData(
                color: Color(0xffa16eeb),
              ),
              child: leadingIcon,
            )),
        title: Container(
          child: Text(
            title,
            style: styleOfList,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true, // Cho phép xuống dòng
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        textColor: MAIN_THEME_PURPLE_TEXT,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Color bg_color = Color(0xFFebdfee);
  final TextStyle styleOfList = TextStyle(
      color: MAIN_THEME_PURPLE_TEXT, fontSize: 20, fontWeight: FontWeight.w500);

  Container buildActions(Icon icon) {
    return Container(
      child: IconTheme(
          data: IconThemeData(
            color: Color(0xFF6200EE),
          ),
          child: icon),
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xffe8a90e), borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData = context.read<MainScreenViewModel>().getListConversation();
  }

  AppBar _buildAppbar() {
    return AppBar(
      leading: Icon(
        LineIcons.userShield,
        color: Color(0xFF6200EE),
      ),
      actions: [
        buildActions(Icon(LineIcons.lightningBolt)),
        buildActions(Icon(LineIcons.fire)),
      ],
    );
  }

  List<String> listTiles = [
    "Ôn lại từ trong flashcard ",
    "Học flashcard của cộng đồng",
    "Conversations đã hoàn thành",
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SpinKitFadingFour(
              color: Colors.white,
            );

          return Scaffold(
            backgroundColor: Color(0xffF8F9FA),
            appBar: _buildAppbar(),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Chào mừng bạn trở lại, \n",
                            style: TextStyle(
                                color: MAIN_THEME_PURPLE_TEXT, fontSize: 18)),
                        TextSpan(
                            text: AppManager.getUser()!.name,
                            style: TextStyle(
                                color: MAIN_THEME_PURPLE_TEXT,
                                fontSize: 25,
                                fontWeight: FontWeight.w500))
                      ]),
                    ),
                    AIConversation(
                      conversations:
                          context.read<MainScreenViewModel>().conversation,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Hôm nay chúng ta nên làm gì ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6200EE),
                          fontSize: 25,
                        ),
                      ),
                    ),
                    buildListTile(
                        listTiles[0], Icon(Icons.rate_review_outlined), () {
                      _gotoAllCollections(context);
                    }),
                    buildListTile(listTiles[1], Icon(LineIcons.plusCircle), () {
                      context.push(AppRoute.public_flashcard);
                    }),
                    buildListTile(listTiles[2], Icon(LineIcons.leanpub), () {}),
                    // buildListtile(listTiles[3], Icon(LineIcons.rocketChat), () {
                    //   widget.onTabChange(2);
                    // }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
