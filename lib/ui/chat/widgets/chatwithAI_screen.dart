import 'package:flashcard_learning/ui/chat/view_models/ChatWithAIViewModel.dart';
import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';
import 'package:flashcard_learning/utils/LoadingOverlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../../utils/color/AllColor.dart';
import 'ContentChatContainer.dart';

class ChatWithAIPage extends StatefulWidget {
  const ChatWithAIPage({super.key});

  @override
  State<ChatWithAIPage> createState() => _ChatWithAiPageState();
}

class _ChatWithAiPageState extends State<ChatWithAIPage> {
  TextEditingController searchController = TextEditingController();
  final TextEditingController askingController = TextEditingController();
  late Future<void> data;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Future<void> _onItemTapped(String name) async {
    LoadingOverlay.show(context);

    await Provider.of<ChatWithAIViewModel>(context, listen: false)
        .setNameOfConversation(name);

    if (mounted) {
      LoadingOverlay.hide();
      Navigator.of(context).pop();
    }
  }

  bool isAsking = false;

  IconThemeData iconThemeData = const IconThemeData(
    size: 25,
    color: Color(0xffffbe29),
  );

  void sendMessage(String text) async {
    _scrollToFocusedField(1000);
    ChatWithAIViewModel chatWithAIViewModel =
        Provider.of<ChatWithAIViewModel>(context, listen: false);
    bool sentSuccessfully =
        await chatWithAIViewModel.sendMessage(askingController.text);

    if (!sentSuccessfully) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              contentTextStyle: TextStyle(fontSize: 15, color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.red, fontSize: 30),
              content: Text("Check internet connection "),
            );
          });
    }
  }

  void attachImage() {}

  Future<void> loadData() async {
    await Provider.of<ChatWithAIViewModel>(context, listen: false).loadData();
  }

  List<ContentChatContainer> buildChatColumn() {
    ChatWithAIViewModel chatWithAIViewModel =
        Provider.of<ChatWithAIViewModel>(context, listen: false);
    List<ContentChatContainer> listChat = [];
    for (int i = 0; i < chatWithAIViewModel.chatList.length; i++) {
      i % 2 == 0
          ? listChat.add(
              ContentChatContainer(
                isBot: false,
                content: chatWithAIViewModel.chatList[i],
                isLoading: false,
              ),
            )
          : listChat.add(ContentChatContainer(
              isBot: true,
              content: chatWithAIViewModel.chatList[i],
              isLoading: false,
            ));
    }
    return listChat;
  }

  @override
  void initState() {
    super.initState();
    data = loadData();
  }

  void askByVoice() {}
  ScrollController _scrollController = ScrollController();

  void _scrollToFocusedField(double offset) {
    Future.delayed(const Duration(milliseconds: 250), () {
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    askingController.dispose();
    searchController.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                LineIcons.newspaper,
                size: 28,
              ),
            )
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Receive Plus version "),
              Icon(
                CupertinoIcons.plus_app,
                color: Colors.purple,
              )
            ],
          ),
        ),
        drawer: Consumer<ChatWithAIViewModel>(
            builder: (context, chatWithAIViewModel, child) {
          return Drawer(
            backgroundColor: MAIN_THEME_YELLOW,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: SearchBar(
                    onTap: () {
                      setState(() {
                        //  isSearch = true;
                      });
                    },
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {
                        //isSearch = false;
                      });
                    },
                    controller: searchController,
                    elevation: WidgetStateProperty.all(3.0),
                    shadowColor: WidgetStateProperty.all(
                        MAIN_THEME_PURPLE.withOpacity(0.2)),
                    side: WidgetStateProperty.all(
                      BorderSide(
                        color: MAIN_THEME_YELLOW_TEXT,
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
                        color: MAIN_THEME_YELLOW_TEXT,
                        size: 30.0,
                      ),
                    ),
                    hintText: "Tìm kiếm",
                    hintStyle: WidgetStateProperty.all(
                      TextStyle(
                        color: MAIN_THEME_YELLOW_TEXT,
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
                          horizontal: 16.0, vertical: 5.0),
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      Colors.white.withOpacity(0.95),
                    ),
                    surfaceTintColor:
                        WidgetStateProperty.all(Colors.transparent),
                  ),
                ),
                ...chatWithAIViewModel.conversationList.map((e) => ListTile(
                      onTap: () => _onItemTapped(e),
                      title: Text(e),
                    )),
              ],
            ),
          );
        }),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: data,
                    builder: (context, snapshot) {
                      return Consumer<ChatWithAIViewModel>(
                          builder: (context, chatWithAIViewModel, child) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: SpinKitFadingFour(
                            color: Colors.yellowAccent,
                          ));
                        }
                        return SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(children: [
                            ...buildChatColumn(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.55,
                            )
                          ]),
                        );
                      });
                    })),
            Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 5, bottom: 15),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(width: 2)),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
              ),
              child: Column(
                children: [
                  TextField(
                    minLines: 1,
                    maxLines: 5,
                    onTapOutside: (e) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: askingController,
                    onTap: () {
                      setState(() {
                        isAsking = true;
                      });
                    },
                    decoration: const InputDecoration(
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      hintText: 'Type your message...',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: IconTheme(
                            data: iconThemeData,
                            child: Icon(
                              CupertinoIcons.plus_circle_fill,
                            ),
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: IconTheme(
                            data: iconThemeData,
                            child: Icon(Icons.mic),
                          )),
                      IconButton(
                          onPressed: () {
                            sendMessage(askingController.text);
                            askingController.clear();
                          },
                          icon: IconTheme(
                            data: iconThemeData,
                            child: const Icon(Icons.send),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
