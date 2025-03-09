import 'dart:io';

import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'account_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  TextStyle subTextStyle = TextStyle(color: MAIN_THEME_BLUE_TEXT);
  TextStyle mainTextStyle = TextStyle(color: MAIN_THEME_BLUE_TEXT);

  AppBar _buildAppbar() {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.navigate_before,
            color: Color(0xFF6200EE),
          )),
      title: Text(
        "Profile",
        style: TextStyle(color: MAIN_THEME_BLUE_TEXT),
      ),
      centerTitle: true,
    );
  }

  Widget containerAvatar(AccountViewModel accountViewModel) {
    return Container(
      width: 60,
      height: 60,
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50000)),
              color: Colors.greenAccent),
        ),
        Align(
            alignment: Alignment.center,
            child: accountViewModel.user.avatarPath.isEmpty
                ? const Icon(
                    LineIcons.user,
                    size: 50,
                  )
                : Image.file(File(accountViewModel.user.avatarPath))),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(5000))),
              child: GestureDetector(
                child: Icon(
                  CupertinoIcons.camera_viewfinder,
                  size: 20,
                ),
                onTap: () async {
                  await accountViewModel.pickImageLocal();
                },
              )),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbar(),
        body: Consumer<AccountViewModel>(
            builder: (context, accountViewModel, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                containerAvatar(accountViewModel),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Trạng thái "),
                          Text("Miễn Phí "),
                        ],
                      ),
                      ElevatedButton(
                        child: Text("Nâng cấp"),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tên người dùng"),
                          SizedBox(
                            width: 160,
                            child: TextField(
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.name,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: accountViewModel.user.name,
                                // Văn bản gợi ý
                                hintStyle: TextStyle(color: Colors.grey),
                                // Màu sắc cho văn bản gợi ý
                                border:
                                    OutlineInputBorder(), // Đường viền cho TextField
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextButton(onPressed: () {}, child: Text("Chỉnh sửa ")),
                    ],
                  ),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                      onPressed: () {},
                      child: Text("Xóa hoàn toàn tài khoản ")),
                ))
              ],
            ),
          );
        }));
  }
}
