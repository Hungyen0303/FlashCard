import 'package:flashcard_learning/routing/router.dart';
import 'package:flashcard_learning/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:flashcard_learning/ui/auth/login/widgets/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/route.dart';
import '../../../../utils/color/AllColor.dart';
import '../../../../logo.dart';

class Forgetpasswordpage extends StatefulWidget {
  const Forgetpasswordpage({super.key});

  @override
  State<Forgetpasswordpage> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpasswordpage> {
  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    final ScrollController _scrollController = ScrollController();
    void _scrollToFocusedField(double offset) {
      // Đợi một chút để keyboard hiện lên
      Future.delayed(const Duration(milliseconds: 250), () {
        _scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }

    return Scaffold(
      backgroundColor: COLOR_LOGIN_BACKGROUND,
      body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 25.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [COLOR_LOGIN_BACKGROUND, MAIN_COLOR])),
                child: Column(
                  children: [
                    Logo(),
                    Text(
                      "Instilled with vocab, ready to break language barrier",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 25),
                    ),
                  ],
                ),
              ),
              Container(
                height: 600, // MediaQuery.of(context).size.height - 150,
                decoration: BoxDecoration(
                    color: const Color(0xFFeaefee),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0))),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35.0, right: 24.0, bottom: 25.0, top: 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Enter your email  ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 35,
                                color: MAIN_COLOR,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40.0, top: 12, bottom: 25),
                          child: TextFormField(
                            onTap: () => _scrollToFocusedField(300),
                            textAlign: TextAlign.left,
                            obscureText: true,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: _passwordController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: MAIN_COLOR),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 20.0),
                              labelText: 'Retype password',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: MAIN_COLOR,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.green[200]!,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.green[700]!,
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.green[50],
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 140.0),
                                backgroundColor: MAIN_TEXT_COLOR,
                                foregroundColor: Colors.white,
                                animationDuration: Duration(seconds: 5),
                                elevation: 4.0),
                            onPressed: () {},
                            child: Text(
                              "Sign up",
                              style: TextStyle(color: MAIN_COLOR),
                            )),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Already have an account ?",
                                  style: TextStyle(color: Colors.black87)),
                              GestureDetector(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: Text(" Login ",
                                      style: TextStyle(color: MAIN_COLOR))),
                            ]),
                      ],
                    )),
              )
            ],
          )),
    );
  }
}
