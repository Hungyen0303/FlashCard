import 'package:flashcard_learning/ui/home/view_models/MainScreenViewModel.dart';
import 'package:flashcard_learning/utils/LoadingOverlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:provider/provider.dart';

import '../../chat/widgets/ContentChatContainer.dart';

class ConversationAIScreen extends StatefulWidget {
  const ConversationAIScreen(
      {super.key, required this.title, required this.level});

  final String title;
  final String level;

  @override
  State<ConversationAIScreen> createState() => _ConversationAIScreenState();
}

class _ConversationAIScreenState extends State<ConversationAIScreen> {
  final TextEditingController askingController = TextEditingController();
  late Future<void> data;

  bool isAsking = false;
  bool sending = false;

  IconThemeData iconThemeData = const IconThemeData(
    size: 25,
    color: Color(0xffffbe29),
  );

  Future<void> sendMessage(String text) async {
    _scrollToBottom();
    MainScreenViewModel conversationAiViewModel =
        context.read<MainScreenViewModel>();
    bool sentSuccessfully = await conversationAiViewModel.saveMessage(text, "");

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

  List<Widget> buildChatColumn() {
    MainScreenViewModel conversationAiViewModel =
        context.read<MainScreenViewModel>();
    List<Widget> listChat = [];
    for (int i = 0; i < conversationAiViewModel.chatList.length; i++) {
      listChat
        ..add(
          ContentChatContainer(
            isBot: false,
            content: conversationAiViewModel.chatList[i].humanChat ?? "",
            isLoading: false,
          ),
        )
        ..add(ContentChatContainer(
          isBot: true,
          content: conversationAiViewModel.chatList[i].botChat ?? "",
          isLoading: false,
        ));
    }
    return listChat;
  }

  @override
  void initState() {
    super.initState();
    data = context
        .read<MainScreenViewModel>()
        .initialize(widget.title, widget.level);
  }

  final ScrollController _scrollController = ScrollController();

  void _scrollToFocusedField(double offset) {
    if (_scrollController != null && _scrollController!.hasClients) {
      Future.delayed(const Duration(milliseconds: 250), () {
        _scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 250),
          curve: Curves.bounceInOut,
        );
      });
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 250), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent, // Cuộn đến cuối
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    askingController.dispose();
  }

  Color mainColor = const Color(0xFF726D14);
  Color mainColorIcon = const Color(0xFFD9CD14);

  AppBar _buildAppbar() {
    return AppBar(
      centerTitle: true,
      elevation: 8,
      leading: IconButton(
          onPressed: () {
            context.read<MainScreenViewModel>().clear();
            context.pop();
          },
          icon: Icon(Icons.navigate_before)),
      shadowColor: Colors.black.withOpacity(0.3),
      title: Text(widget.title),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffd8dadc), // Xanh dương nhạt
              Color(0xfff8fdff), // Tím nhạt
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildInputBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.9), // Nền trắng mờ
            Colors.grey.shade100, // Xám nhạt
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border(top: BorderSide(width: 2, color: Colors.grey.shade300)),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Thu nhỏ chiều cao container
        children: [
          TextField(
            minLines: 1,
            maxLines: 5,
            controller: askingController,
            onTapOutside: (e) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onTap: () {
              setState(() {
                isAsking = true;
              });
              _scrollToFocusedField(15000);
            },
            decoration: InputDecoration(
              hintText: 'Type your message...',
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 16,
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 1.5,
                ),
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: mainColorIcon,
                ),
                onPressed: () async {
                  if (askingController.text.isNotEmpty) {
                    String content = askingController.text;
                    askingController.clear();

                    await sendMessage(content);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<MainScreenViewModel>(
              builder: (context, conversationAiViewModel, child) {
            return PieCanvas(
              child: Scaffold(
                  appBar: _buildAppbar(),
                  body: Column(
                    children: [
                      Expanded(
                          child: FutureBuilder(
                              future: data,
                              builder: (context, snapshot) {
                                return Consumer<MainScreenViewModel>(
                                    builder:
                                        (context, chatWithAIViewModel, child) {
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      )
                                    ]),
                                  );
                                });
                              })),
                      context.read<MainScreenViewModel>().isDone
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 10),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color(0xff69e7ad),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Congratulation 🎉🎉 "
                                "\n You just completed this conversation"
                                "\n Average Score:  ${context.read<MainScreenViewModel>().averageScore} ",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFF09411A)),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : SizedBox.shrink(),
                      _buildInputBox(),
                    ],
                  )),
            );
          });
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitFadingFour(
            color: Colors.white,
          );
        } else
          return SizedBox.shrink();
      },
    );
  }
}
