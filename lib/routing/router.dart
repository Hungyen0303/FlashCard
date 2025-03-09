import 'package:flashcard_learning/routing/route.dart';
import 'package:flashcard_learning/ui/auth/forgetpassword/widgets/forgetpassword_screen.dart';
import 'package:flashcard_learning/ui/auth/register/widgets/register_screen.dart';
import 'package:flashcard_learning/ui/dictionary/SearchByImage.dart';
import 'package:flashcard_learning/ui/specific_flashcard/specific_flashcard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../ui/account/profile_screen.dart';
import '../ui/auth/login/view_models/login_viewmodel.dart';
import '../ui/auth/login/widgets/login_screen.dart';
import '../ui/flashcard_sets/widgets/flashcard_sets_public_screen.dart';
import '../ui/home/widgets/onboard_screen.dart';
import '../ui/home/widgets/shell_screen.dart';

class AppRouter {
  final routeLogger = Logger('ROUTE');

  static final GoRouter route = GoRouter(
      initialLocation: '/boarding',
      errorBuilder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  "There was no URL  ",
                  style: TextStyle(fontSize: 30, color: Colors.red),
                )),
                ElevatedButton(
                    onPressed: () {
                      context.go(AppRoute.home);
                    },
                    child: Text("Back to home"))
              ],
            ),
          ),
      routes: [
        GoRoute(
            path: AppRoute.home,
            builder: (context, state) {
              return const Homepage();
            }),
        GoRoute(
            path: AppRoute.boarding,
            builder: (context, state) {
              return const OnBoardingPage();
            }),
        GoRoute(
            path: AppRoute.login,
            builder: (context, state) {
              return Loginpage(loginViewModel: context.read());
            }),
        GoRoute(
            path: AppRoute.forgetpassword,
            builder: (context, state) {
              //routeLogger.info(state.name);

              return const Forgetpasswordpage();
            }),
        GoRoute(
            path: AppRoute.signup,
            builder: (context, state) {
              //routeLogger.info(state.name);

              return const RegisterPage();
            }),
        GoRoute(
            path: AppRoute.flashCardSet,
            builder: (context, state) {
              //routeLogger.info(state.name);
              String name = state.pathParameters['name'] ?? "default";
              return SpecificFlashCardPage(nameOfSet: name);
            }),
        GoRoute(
            path: AppRoute.SearchByImagePath,
            builder: (context, state) {
              return SearchByImage();
            }),
        GoRoute(
            path: AppRoute.profile,
            builder: (context, state) {
              return ProfileScreen();
            }),
        GoRoute(
            path: AppRoute.public_flashcard,
            builder: (context, state) {
              return AllFlashCardPublicSet();
            }),
      ]);
}
