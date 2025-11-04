import 'dart:math';

import 'package:flashcard_learning/routing/route.dart';
import 'package:flashcard_learning/utils/LoadingOverlay.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'account_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Container buildActions(Icon icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xffe8a90e), borderRadius: BorderRadius.circular(10)),
      child: IconTheme(
          data: const IconThemeData(
            color: Color(0xFF6200EE),
          ),
          child: icon),
    );
  }

  TextStyle titleText =
      const TextStyle(color: white, fontSize: 15, fontWeight: FontWeight.w700);
  TextStyle contentTextStyle =
      const TextStyle(color: white, fontSize: 25, fontWeight: FontWeight.w300);
  TextStyle buttonTextStyle =
      const TextStyle(color: darkBlue, fontWeight: FontWeight.bold);
  TextEditingController nameController = TextEditingController();

  Color boxColor = darkBlue;

  AppBar _buildAppbar() {
    final l10n = AppLocalizations.of(context)!;
    return AppBar(
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.navigate_before,
            color: darkBlue,
          )),
      title: Text(
        l10n.profile_title,
        style: const TextStyle(color: darkBlue, fontWeight: FontWeight.bold),
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
              child: true
                  ? Image.network(
                      alignment: Alignment.topCenter,
                      'https://picsum.photos/${Random.secure().nextInt(1000)}',
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    )
                  : accountViewModel.currentUser.avatar.isEmpty
                      ? const Icon(LineIcons.user,
                          size: 40, color: Colors.white)
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
                child: const Icon(
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

  Widget _buildBox(String name, Icon icon, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            color: boxColor, borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconTheme(data: const IconThemeData(color: white), child: icon),
            const SizedBox(width: 15),
            Text(name, style: titleText)
          ],
        ),
      ),
    );
  }

  Container _buildBoxInfo(AccountViewModel accountViewModel) {
    final l10n = AppLocalizations.of(context)!;

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
              Text(l10n.profile_username, style: titleText),
              const SizedBox(height: 10),
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
              backgroundColor: white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () async {
              await changeName(context, accountViewModel);
            },
            child: Text(l10n.profile_modify,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                    fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Future<void> changeName(
      BuildContext context, AccountViewModel accountViewModel) async {
    final l10n = AppLocalizations.of(context)!;
    TextEditingController controller = TextEditingController();

    QuickAlert.show(
        context: context,
        type: QuickAlertType.custom,
        showConfirmBtn: true,
        showCancelBtn: true,
        confirmBtnText: l10n.profile_confirm,
        cancelBtnText: l10n.profile_cancel,
        confirmBtnColor: Colors.blue,
        title: l10n.profile_enter_name,
        animType: QuickAlertAnimType.scale,
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
    final l10n = AppLocalizations.of(context)!;

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
                            TextSpan(
                                text: "${l10n.profile_plan}\n",
                                style: titleText),
                            TextSpan(
                              text: accountViewModel.currentUser.plan,
                              style: contentTextStyle,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        onPressed: () {
                          context.push(AppRoute.upgrade);
                        },
                        child:
                            Text(l10n.profile_upgrade, style: buttonTextStyle),
                      ),
                    ],
                  ),
                ),
                _buildBoxInfo(accountViewModel),
                _buildBox(l10n.profile_policy, const Icon(CupertinoIcons.book),
                    () => context.push(AppRoute.policy)),
                _buildBox(
                    l10n.profile_terms,
                    const Icon(CupertinoIcons.archivebox_fill),
                    () => context.push(AppRoute.termOfService)),
              ],
            ),
          );
        }));
  }
}
