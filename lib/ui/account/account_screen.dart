import 'package:flashcard_learning/routing/route.dart';
import 'package:flashcard_learning/ui/account/account_viewmodel.dart';
import 'package:flashcard_learning/ui/auth/AppManager.dart';
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
  // Define color palette based on the dominant color 0xFFA6C7E7

  Future<void> logout(BuildContext context) async {
    AppManager.clearToken();
    context.go(AppRoute.login);
  }

  void _gotoAccountPage() {
    context.push(AppRoute.profile);
  }

  Container buildActions(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: white),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: dominantColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  TextStyle textStyle = const TextStyle(color: darkText);
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: dominantColor.withOpacity(0.2),
    border: Border.all(color: dominantColor, width: 1.5),
  );
  TextStyle textStyleForDuration =
      TextStyle(color: darkBlue, fontWeight: FontWeight.bold, fontSize: 18);

  AppBar _buildAppbar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: white,
      elevation: 0,
      title: Text(
        "👳🏽‍♀️ Account",
        style: TextStyle(
          color: darkBlue,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              // Bottom shadow
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 3.0),
              blurRadius: 6.0,
            ),
            Shadow(
              // Top highlight
              color: Colors.white.withOpacity(0.6),
              offset: Offset(0, -2.0),
              blurRadius: 2.0,
            ),
          ],
        ),
      ),
    );
  }

  Consumer<AccountViewModel> buildProfilePanel() {
    return Consumer<AccountViewModel>(
      builder: (context, accountViewModel, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: lightBlue, width: 1),
            borderRadius: BorderRadius.circular(15),
            color: white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: darkBlue),
                      borderRadius: BorderRadius.circular(500)),
                  height: 60,
                  width: 60,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ClipOval(
                        child: Container(
                          width: 60,
                          height: 60,
                          color: dominantColor,
                          child: accountViewModel.currentUser.avatar.isEmpty
                              ? const Icon(LineIcons.user,
                                  size: 40, color: white)
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
                              color: darkBlue,
                              shape: BoxShape.circle,
                              border: Border.all(color: white, width: 2),
                            ),
                            child: Icon(
                              CupertinoIcons.camera_viewfinder,
                              size: 16,
                              color: white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(
                  accountViewModel.currentUser.name,
                  style:
                      TextStyle(color: darkText, fontWeight: FontWeight.bold),
                ),
                subtitle: GestureDetector(
                    onTap: _gotoAccountPage,
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: darkBlue),
                    )),
                trailing: IconButton(
                  color: darkBlue,
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
              Divider(height: 2, color: dominantColor.withOpacity(0.3)),
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
                              style: textStyle.copyWith(
                                  fontSize: 15, color: lightText)),
                          TextSpan(
                            text: accountViewModel.currentUser.plan,
                            style: textStyle.copyWith(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: darkBlue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onPressed: () {
                      context.push(AppRoute.upgrade);
                    },
                    child: Text(
                      "Upgrade",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: white,
                          fontSize: 16),
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
          border: Border.all(color: lightBlue, width: 1),
          borderRadius: BorderRadius.circular(15),
          color: white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Activities",
                style: TextStyle(
                    color: darkBlue, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "Track your progress",
                style: TextStyle(color: lightText),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 1,
                color: dominantColor.withOpacity(0.3),
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
                              dominantColor,
                              darkBlue,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.book_sharp,
                          color: white,
                          size: 25,
                        ),
                        Text(
                          "${accountViewModel.numOfCompleteConversation}",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: white),
                        ),
                        Text(
                          "BÀI HỌC ĐÃ HOÀN THÀNH",
                          style: TextStyle(
                            color: white.withOpacity(0.9),
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
                              softPink,
                              paleOrange,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lock_clock,
                          color: white,
                          size: 25,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "${accountViewModel.numOfCompleteFlashcard}",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: white),
                        ),
                        Text(
                          "ĐOẠN HỘI THOẠI ĐÃ HOÀN THÀNH",
                          style: TextStyle(
                            color: white.withOpacity(0.9),
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
      backgroundColor: Color(0xFFF5F9FD), // Very light blue background
      appBar: _buildAppbar(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Profile */
              const SizedBox(
                height: 15,
              ),
              buildProfilePanel(),
              buildActivityPanel(),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () async {
                      await logout(context);
                    },
                    child: Text(
                      "Đăng xuất",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
