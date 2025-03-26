import 'package:flashcard_learning/routing/route.dart';
import 'package:flashcard_learning/ui/account/account_viewmodel.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Future<void> logout(BuildContext context) async {
  //   Provider.of<AccountViewModel>(context, listen: false).logout();
    context.go(AppRoute.login);
  }

  void _gotoAccountPage() {
    context.push(AppRoute.profile);
  }

  Container buildActions(Icon icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: const Color(0xffe8a90e),
          borderRadius: BorderRadius.circular(10)),
      child: IconTheme(
          data: const IconThemeData(
            color: Color(0xFF6200EE),
          ),
          child: icon),
    );
  }

  TextStyle textStyle = const TextStyle(color: MAIN_THEME_BLUE_TEXT);
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: Color(0xFF80E886),
  );
  TextStyle textStyleForDuration = TextStyle(
      color: Color(0xFF12A799), fontWeight: FontWeight.bold, fontSize: 18);

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

  Consumer<AccountViewModel> buildProfilePanel() {
    return Consumer<AccountViewModel>(
      builder: (context, accountViewModel, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xffd0eff3),
          ),
          child: Column(
            children: [
              ListTile(
                leading: SizedBox(
                  height: 60,
                  width: 60,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ClipOval(
                        child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.blueGrey,
                          child: accountViewModel.currentUser.avatar.isEmpty
                              ? const Icon(LineIcons.user,
                                  size: 40, color: Colors.white)
                              : Image.network(
                                  alignment: Alignment.topCenter,
                                  accountViewModel.currentUser.avatar,
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
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
                ),
                title: Text(
                  accountViewModel.currentUser.name,
                  style: TextStyle(color: MAIN_THEME_BLUE_TEXT),
                ),
                subtitle: GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xFFDE2D2D)),
                    )),
                trailing: IconButton(
                  color: const Color(0xFFC93030),
                  padding: EdgeInsets.only(left: 30),
                  iconSize: 30,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.navigate_next),
                  onPressed: _gotoAccountPage,
                ),
              ),
              Divider(height: 2, color: Colors.red),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Plan\n",
                              style: textStyle.copyWith(fontSize: 15)),
                          TextSpan(
                            text: accountViewModel.currentUser.plan,
                            style: textStyle.copyWith(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF80E886),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Upgrade",
                      style: textStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Consumer<AccountViewModel> buildActivityPanel() {
    return Consumer<AccountViewModel>(
        builder: (context, accountViewModel, child) {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xffd0eff3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Activities",
                style: textStyle.copyWith(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "Track your progress",
                style: textStyle,
              ),
              SizedBox(
                height: 5,
              ),
              const Divider(
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
                    onTap: () async {
                      await accountViewModel.setCountBy(true);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration:
                          accountViewModel.countByDay ? boxDecoration : null,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        "Last 7 days",
                        style: textStyleForDuration,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await accountViewModel.setCountBy(false);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration:
                          !accountViewModel.countByDay ? boxDecoration : null,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        "Last 12 months",
                        style: textStyleForDuration,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 150,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    width: MediaQuery.of(context).size.width * 0.4,
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
                          "${accountViewModel.numOfCompleteConversation}",
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    width: MediaQuery.of(context).size.width * 0.4,
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
                          "${accountViewModel.numOfCompleteFlashcard}",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Text(
                          "ĐOẠN HỘI THOẠI ĐÃ HOÀN THÀNH",
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
      );
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AccountViewModel>().loadTrackData();
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
              // const SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     GestureDetector(
              //       onTap: () => changeTab(0),
              //       child: Container(
              //         padding: EdgeInsets.symmetric(vertical: 12),
              //         width: MediaQuery.of(context).size.width * 0.45,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(50),
              //             color:
              //                 0 == widget._index ? Colors.grey : Colors.black),
              //         child: Text(
              //           textAlign: TextAlign.center,
              //           "Tiến độ",
              //           style: TextStyle(
              //             color:
              //                 0 == widget._index ? Colors.black : Colors.white,
              //           ),
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () => changeTab(1),
              //       child: Container(
              //         padding: EdgeInsets.symmetric(vertical: 10),
              //         width: MediaQuery.of(context).size.width * 0.45,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(50),
              //             color:
              //                 1 == widget._index ? Colors.grey : Colors.black),
              //         child: Text(
              //           textAlign: TextAlign.center,
              //           "Thành tựu",
              //           style: TextStyle(
              //             color:
              //                 1 == widget._index ? Colors.black : Colors.white,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              /*Profile */
              const SizedBox(
                height: 15,
              ),
              buildProfilePanel(),
              buildActivityPanel(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xfffe3030),
                    ),
                    onPressed: () async {
                      await logout(context);
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
