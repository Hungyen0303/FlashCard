import 'package:flashcard_learning/domain/models/Conversation.dart';
import 'package:flashcard_learning/domain/models/Message.dart';
import 'package:flashcard_learning/ui/chat/view_models/ChatWithAIViewModel.dart';
import 'package:flashcard_learning/utils/LoadingOverlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

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

  Future<void> _onItemTapped(int index) async {
    LoadingOverlay.show(context);

    await Provider.of<ChatWithAIViewModel>(context, listen: false)
        .setIndexOfConversation(index);

    if (mounted) {
      LoadingOverlay.hide();
      context.pop();
      _scrollToBottom();
    }
  }

  bool isAsking = false;
  bool sending = false;

  IconThemeData iconThemeData = const IconThemeData(
    size: 25,
    color: Color(0xffffbe29),
  );

  Future<void> sendMessage(String text) async {
    _scrollToBottom();
    ChatWithAIViewModel chatWithAIViewModel =
        context.read<ChatWithAIViewModel>();
    bool sentSuccessfully = await chatWithAIViewModel.saveMessage(text);
    _scrollToBottom();
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

  List<Widget> buildChatColumn() {
    ChatWithAIViewModel chatWithAIViewModel =
        context.read<ChatWithAIViewModel>();
    List<Widget> listChat = [];
    for (int i = 0; i < chatWithAIViewModel.chatList.length; i++) {
      listChat
        ..add(
          ContentChatContainer(
            isBot: false,
            content: chatWithAIViewModel.chatList[i].humanChat ?? "",
            isLoading: false,
          ),
        )
        ..add(ContentChatContainer(
          isBot: true,
          content: chatWithAIViewModel.chatList[i].botChat ?? "",
          isLoading: false,
        ));
    }
    return listChat;
  }

  List<Widget> _buildChatTiles(ChatWithAIViewModel chatWithAIViewModel) {
    List<Widget> chatTiles = [];
    for (int i = 0; i < chatWithAIViewModel.conversationList.length; i++) {
      final Conversation e = chatWithAIViewModel.conversationList[i];
      final bool isSelected =
          i == chatWithAIViewModel.indexOfCurrentConversation;

      chatTiles.add(PieMenu(
          onPressed: () {
            _onItemTapped(i);
          },
          actions: [
            PieAction(
              tooltip: const Text('Edit'),
              onSelect: () =>
                  _showRenameDialog(context, i, chatWithAIViewModel),

              /// Optical correction
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: FaIcon(FontAwesomeIcons.penToSquare),
              ),
            ),
            PieAction(
              buttonTheme: PieButtonTheme(
                  backgroundColor: Colors.red, iconColor: Colors.white),
              tooltip: const Text('Delete'),
              onSelect: () => _confirmDelete(context, i, chatWithAIViewModel),
              child: const FaIcon(
                FontAwesomeIcons.trash,
              ),
            ),
          ],
          child: ListTile(
            title: Text(
              e.name,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16, // Kích thước chữ cố định cho đồng bộ
                color: isSelected
                    ? Colors.black87
                    : Colors.black54, // Đậm hơn khi chọn
              ),
            ),
          )));
    }
    return chatTiles;
  }

  void _showRenameDialog(BuildContext context, int index,
      ChatWithAIViewModel chatWithAIViewModel) {
    final TextEditingController controller = TextEditingController(
      text: chatWithAIViewModel.conversationList[index].name,
    );

    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      onConfirmBtnTap: () async {
        await chatWithAIViewModel.editConversation(
            index, Conversation(name: controller.text));
        context.pop();
      },
      onCancelBtnTap: () {
        context.pop();
      },
      animType: QuickAlertAnimType.slideInLeft,
      confirmBtnText: "OK",
      cancelBtnText: "Cancle",
      showCancelBtn: true,
      title: 'Rename Conversation',
      widget: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Enter new name',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  // void _showRenameDialogForChatContent(
  //     BuildContext context, int i, ChatWithAIViewModel chatWithAIViewModel) {
  //   final TextEditingController controller = TextEditingController(
  //     text: chatWithAIViewModel.conversationList[i].name,
  //   );
  //
  //   QuickAlert.show(
  //     context: context,
  //     type: QuickAlertType.info,
  //     onConfirmBtnTap: () async {
  //       await chatWithAIViewModel.editMessage(i, Message());
  //     },
  //     onCancelBtnTap: () {
  //       context.pop();
  //     },
  //     animType: QuickAlertAnimType.slideInLeft,
  //     confirmBtnText: "OK",
  //     cancelBtnText: "Cancle",
  //     showCancelBtn: true,
  //     title: 'Rename Conversation',
  //     widget: TextField(
  //       controller: controller,
  //       decoration: InputDecoration(
  //         hintText: 'Enter new name',
  //         border: OutlineInputBorder(),
  //       ),
  //     ),
  //   );
  // }

  void _confirmDelete(BuildContext context, int index,
      ChatWithAIViewModel chatWithAIViewModel) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      onConfirmBtnTap: () async {
        await chatWithAIViewModel.deleteConversation(index);
        context.pop();
      },
      onCancelBtnTap: () {
        context.pop();
      },
      animType: QuickAlertAnimType.slideInLeft,
      confirmBtnText: "OK",
      cancelBtnText: "Cancle",
      showCancelBtn: true,
      title: 'Delete Conversation',
      titleColor: Colors.red,
      widget: Text(
        "Are you sure to delete this conversation ",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Color(0xFF123456)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    data = context.read<ChatWithAIViewModel>().loadConversationList();
  }

  void askByVoice() {}
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
    searchController.dispose();
  }

  Color mainColor = const Color(0xFF726D14);
  Color mainColorIcon = darkBlue;

  AppBar _buildAppbar() {
    return AppBar(
      centerTitle: true,
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.3),
      // Màu bóng
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // Giới hạn kích thước title
        children: [
          Text(
            "Receive Plus Version",
            style: TextStyle(
              fontSize: 20, // Tăng kích thước chữ
              fontWeight: FontWeight.bold, // Chữ đậm
              color: darkBlue,
              letterSpacing: 1.2, // Khoảng cách chữ
            ),
          ),
          SizedBox(width: 8), // Khoảng cách giữa text và icon
          Icon(
            CupertinoIcons.plus_app,
            color: mainColorIcon, // Đổi màu trắng cho đồng bộ
            size: 28, // Tăng kích thước icon
            // shadows: [
            //   Shadow(
            //     color: Colors.black.withOpacity(0.3),
            //     blurRadius: 4,
            //     offset: Offset(0, 2),
            //   ),
            // ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16), // Tăng padding
          child: GestureDetector(
            onTap: () {
              context.read<ChatWithAIViewModel>().setIndexOfConversation(-1);
              askingController.clear();
            },
            child: Container(
              padding: EdgeInsets.all(8), // Khu vực nhấn lớn hơn
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Bo tròn
                color: Colors.white.withOpacity(0.2), // Nền nhẹ
              ),
              child: FaIcon(
                FontAwesomeIcons.penToSquare,
                size: 22,
                color: mainColorIcon,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Drawer _buildDrawer(ChatWithAIViewModel chatWithAIViewModel) {
    return Drawer(

      backgroundColor: Color(0xFFC5DDF5), // Nền vàng chủ đạo
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header cho Drawer (tùy chọn)
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Conversations",
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SearchBar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: SearchBar(
                onTap: () {
                  setState(() {
                  });
                },
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                  });
                },
                controller: searchController,
                elevation: WidgetStateProperty.all(3.0),
                shadowColor: WidgetStateProperty.all(
                  darkBlue.withOpacity(0.2),
                ),
                side: WidgetStateProperty.all(
                  BorderSide(
                    color: darkBlue,
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
                    color: darkBlue,
                    size: 30.0,
                  ),
                ),
                hintText: "Search",
                hintStyle: WidgetStateProperty.all(
                  TextStyle(
                    color: darkBlue,
                    fontSize: 16.0,
                  ),
                ),
                textStyle: WidgetStateProperty.all(
                  TextStyle(
                    color: darkText,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                ),
                backgroundColor: WidgetStateProperty.all(
                  Colors.white.withOpacity(0.95),
                ),
                surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
              ),
            ),
            // Danh sách chat tiles
            ..._buildChatTiles(chatWithAIViewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildBlank() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
           darkBlue,
            Color(0xFF4E7BA2),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon lớn
            Icon(
              LineIcons.comments,
              size: 100,
              color: Colors.white.withOpacity(0.9),
            ),
            SizedBox(height: 20),
            // Text hướng dẫn
            const Text(
              "Start a Conversation",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black45,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Select a conversation from the menu\nor create a new one to begin chatting!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 30),
            // Nút tạo cuộc hội thoại
            // ElevatedButton.icon(
            //   onPressed: () {
            //     Scaffold.of(context).openDrawer();
            //   },
            //   icon: Icon(CupertinoIcons.plus_circle_fill, size: 24),
            //   label: Text(
            //     "New Conversation",
            //     style: TextStyle(fontSize: 18),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: Color(0xFF123456),
            //     backgroundColor: Colors.white,
            //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //     elevation: 5,
            //     shadowColor: Colors.black45,
            //   ),
            // ),
          ],
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
              IconButton(
                icon:
                    Icon(CupertinoIcons.plus_circle_fill, color: mainColorIcon),
                onPressed: () {
                  // Xử lý attach file (nếu cần)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Attach file tapped")),
                  );
                },
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  Icons.mic,
                  color: mainColorIcon,
                ),
                onPressed: () {},
              ),
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
          return Consumer<ChatWithAIViewModel>(
              builder: (context, chatWithAIViewModel, child) {
            return PieCanvas(
              theme: PieTheme(
                buttonSize: 45,
                overlayColor: const Color(0x37F1E397).withOpacity(0.7),
                rightClickShowsMenu: true,
                tooltipTextStyle: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Scaffold(
                  appBar: _buildAppbar(),
                  drawer: _buildDrawer(chatWithAIViewModel),
                  body: Column(
                    children: [
                      Expanded(
                          child: FutureBuilder(
                              future: data,
                              builder: (context, snapshot) {
                                return Consumer<ChatWithAIViewModel>(builder:
                                    (context, chatWithAIViewModel, child) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: SpinKitFadingFour(
                                      color: Colors.yellowAccent,
                                    ));
                                  }
                                  return chatWithAIViewModel
                                              .indexOfCurrentConversation !=
                                          -1
                                      ? SingleChildScrollView(
                                          controller: _scrollController,
                                          child: Column(children: [
                                            ...buildChatColumn(),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                            )
                                          ]),
                                        )
                                      : _buildBlank();
                                });
                              })),
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
