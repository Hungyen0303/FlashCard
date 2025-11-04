import 'package:flashcard_learning/l10n/app_localization.dart';
import 'package:flashcard_learning/routing/route.dart';
import 'package:flashcard_learning/ui/account/account_viewmodel.dart';
import 'package:flashcard_learning/ui/home/view_models/MainScreenViewModel.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flashcard_learning/utils/locale_provider.dart';
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

  void showLanguageSelectionDialog(BuildContext context) {
    final provider = context.read<LocaleProvider>();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Select Language'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Image.asset('assets/vietnam.png', width: 35),
                    title: const Text('Tiếng Việt'),
                    onTap: () {
                      if (provider.locale.languageCode == 'en') {
                        provider.setLocale(const Locale('vi'));
                      }
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Image.asset('assets/us.png', width: 35),
                    title: const Text('English'),
                    onTap: () {
                      if (provider.locale.languageCode == 'vi') {
                        provider.setLocale(const Locale('en'));
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ));
  }

  AppBar _buildAppbar() {
    return AppBar(
      actions: [
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Image.asset('assets/languages.png', width: 35),
          ),
          onTap: () => showLanguageSelectionDialog(context),
        )
      ],
      title: const Text(
        "🏠 ",
        style: TextStyle(
            color: MAIN_TITLE_COLOR, fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<String> listTiles = [
    "", // will set below
    "",
  ];

  @override
  Widget build(BuildContext context) {
    listTiles[0] = context.l10n.home_review_flashcard;
    listTiles[1] = context.l10n.home_learn_public;

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
                  TextSpan(
                      text: context.l10n.home_welcome_back,
                      style: const TextStyle(
                          color: MAIN_TITLE_COLOR, fontSize: 18)),
                  TextSpan(
                      text: AppManager.getUser()!.name,
                      style: const TextStyle(
                          color: MAIN_TITLE_COLOR,
                          fontSize: 25,
                          fontWeight: FontWeight.w500))
                ]),
              ),
              const AIConversation(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  context.l10n.home_what_should_do_today,
                  style: const TextStyle(
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
