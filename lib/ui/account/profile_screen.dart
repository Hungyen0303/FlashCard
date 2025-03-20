import 'package:flashcard_learning/utils/LoadingOverlay.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

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

  TextStyle titleText = TextStyle(
      color: MAIN_THEME_BLUE_TEXT, fontSize: 15, fontWeight: FontWeight.w700);
  TextStyle contentTextStyle = TextStyle(
      color: Color(0xFF6C88E5), fontSize: 25, fontWeight: FontWeight.bold);
  TextStyle buttonTextStyle =
      const TextStyle(color: MAIN_THEME_BLUE_TEXT, fontWeight: FontWeight.bold);
  TextEditingController nameController = TextEditingController();

  Color boxColor = const Color(0xFFBDDDEA);

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
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.green),
          color: Colors.red,
          borderRadius: BorderRadius.circular(50000)),
      height: 80,
      width: 80,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipOval(
            child: Container(
              child: accountViewModel.currentUser.avatar.isEmpty
                  ? const Icon(LineIcons.user, size: 40, color: Colors.white)
                  : Image.network(
                      alignment: Alignment.topCenter,
                      accountViewModel.currentUser.avatar,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
            ),
          ),
          Align(
            alignment: const Alignment(1.4, 1.4),
            child: GestureDetector(
              onTap: () async {
                await accountViewModel.changeAvatar();
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  CupertinoIcons.camera_viewfinder,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildBox(String name, Icon icon, Function ontap) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(5)),
      child: GestureDetector(
        onTap: () => ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconTheme(
                data: IconThemeData(color: MAIN_THEME_BLUE_TEXT), child: icon),
            SizedBox(
              width: 15,
            ),
            Text(
              name,
              style: titleText,
            )
          ],
        ),
      ),
    );
  }

  Container _buildBoxInfo(AccountViewModel accountViewModel) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tên người dùng",
                style: titleText,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 160,
                child: Text(
                  accountViewModel.currentUser.name,
                  style: contentTextStyle,
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF80E886),
            ),
            onPressed: () async {
              await changeName(context, accountViewModel);
            },
            child: Text(
              "Modify",
              style: buttonTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> changeName(
      BuildContext context, AccountViewModel accountViewModel) async {
    TextEditingController controller = TextEditingController();

    QuickAlert.show(
        context: context,
        type: QuickAlertType.custom,
        showConfirmBtn: true,
        showCancelBtn: true,
        confirmBtnText: "Confirm",
        confirmBtnColor: Colors.blue,
        title: "Please enter your name",
        animType: QuickAlertAnimType.scale,
        cancelBtnText: "Cancel",
        widget: SizedBox(
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
          ),
        ),
        onConfirmBtnTap: () async {
          if (accountViewModel.currentUser.name != controller.text) {
            LoadingOverlay.show(context);
            await accountViewModel.updateName(controller.text);
            LoadingOverlay.hide();
            context.pop();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbar(),
        body: Consumer<AccountViewModel>(
            builder: (context, accountViewModel, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                containerAvatar(accountViewModel),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      color: boxColor, borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: "Plan\n", style: titleText),
                            TextSpan(
                              text: accountViewModel.currentUser.plan,
                              style: contentTextStyle,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF80E886),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Upgrade",
                          style: buttonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildBoxInfo(accountViewModel),
                _buildBox("Chính sách ", Icon(CupertinoIcons.book), () {}),
                _buildBox("Điều khoản ", Icon(CupertinoIcons.book), () {}),
                _buildBox("Thông báo ", Icon(CupertinoIcons.bell), () {}),
                // Expanded(
                //     child: Align(
                //   alignment: Alignment.bottomCenter,
                //   child: TextButton(
                //       onPressed: () {},
                //       child: Text("Xóa hoàn toàn tài khoản ")),
                // ))
              ],
            ),
          );
        }));
  }
}
