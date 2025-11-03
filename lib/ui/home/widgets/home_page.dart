import 'package:flashcard_learning/routing/route.dart';
import 'package:flashcard_learning/ui/account/account_viewmodel.dart';
import 'package:flashcard_learning/ui/home/view_models/MainScreenViewModel.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../../../AppManager.dart';
import 'ai_conversation.dart';
import '../../flashcard_sets/widgets/flashcard_sets_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onTabChange});

  final Function onTabChange;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _gotoAllCollections(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const AllFlashCardSet()));
  }

  Widget buildListTile(
      {required String title,
      required IconData leadingIcon,
      required Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        horizontalTitleGap: 30,
        splashColor: Colors.deepPurpleAccent,
        focusColor: Colors.blue,
        iconColor: Colors.red,
        tileColor: MAIN_BOX_COLOR,
        trailing: Container(
          width: 45,
          height: 45,
          margin: const EdgeInsets.only(right: 10),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffa16eeb), Color(0xFF6200EE)]),
              color: Colors.red,
              shape: BoxShape.circle),
          child: const Icon(
            color: Colors.white,
            Icons.navigate_next,
          ),
        ),
        onTap: () => onPressed(),
        leading: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              "📗",
              style: TextStyle(fontSize: 25),
            )),
        title: Text(
          title,
          style: styleOfList,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: true, // Cho phép xuống dòng
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        textColor: MAIN_THEME_PURPLE_TEXT,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  final TextStyle styleOfList = const TextStyle(
      letterSpacing: 0.4,
      color: lightText,
      fontSize: 20,
      fontWeight: FontWeight.w600);

  @override
  void initState() {
    super.initState();

    final mainScreenViewModel =
        Provider.of<MainScreenViewModel>(context, listen: false);
    final accountViewModel =
        Provider.of<AccountViewModel>(context, listen: false);
    mainScreenViewModel.onDoneChanged = () {
      accountViewModel.changeNumOfCompleteConversation();
    };
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: const Text(
        "🏠 ",
        style: TextStyle(
            color: MAIN_TITLE_COLOR, fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<String> listTiles = [
    "Ôn lại từ trong flashcard ",
    "Học flashcard của cộng đồng",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      appBar: _buildAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: "Chào mừng bạn trở lại, \n",
                      style: TextStyle(color: MAIN_TITLE_COLOR, fontSize: 18)),
                  TextSpan(
                      text: AppManager.getUser()!.name,
                      style: const TextStyle(
                          color: MAIN_TITLE_COLOR,
                          fontSize: 25,
                          fontWeight: FontWeight.w500))
                ]),
              ),
              AIConversation(),
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Hôm nay chúng ta nên làm gì ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2489EE),
                    fontSize: 25,
                  ),
                ),
              ),
              buildListTile(
                  title: listTiles[0],
                  leadingIcon: Icons.rate_review_outlined,
                  onPressed: () {
                    _gotoAllCollections(context);
                  }),
              buildListTile(
                  title: listTiles[1],
                  leadingIcon: LineIcons.plusCircle,
                  onPressed: () {
                    context.push(AppRoute.public_flashcard);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
