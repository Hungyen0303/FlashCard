import 'package:flashcard_learning/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flashcard_learning/ui/auth/forgetpassword/widgets/forgetpassword_screen.dart';
import 'package:flashcard_learning/ui/home/widgets/shell_screen.dart';
import 'package:flashcard_learning/ui/home/widgets/onboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../logo.dart';
import '../../register/widgets/register_screen.dart';
import '../../../test/Testpage.dart';

class Loginpage extends StatelessWidget {
  Loginpage({super.key, required this.loginViewModel});

  final LoginViewModel loginViewModel;

  void _gotoRegisterPage(context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => RegisterPage()));
  }

  void _gotoTest(context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => TestPage()));
  }

  void _gotoForgetPasswordPage(context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Forgetpasswordpage()));
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();

  void login(GlobalKey<FormState> formState, BuildContext context) {
    if (formState.currentState!.validate()) {
      loginViewModel.login(_emailController.text, _passwordController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const Homepage()));
    } else {}
  }

  void _scrollToFocusedField(double offset) {
    // Đợi một chút để keyboard hiện lên
    Future.delayed(const Duration(milliseconds: 250), () {
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _emailController.text = "nguyenvana@gmail.com";
    _passwordController.text = "123456789s";

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
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 35.0, right: 24.0, bottom: 25.0, top: 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Login",
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
                              left: 40, right: 40.0, top: 25.0),
                          child: TextFormField(
                            onTap: () => _scrollToFocusedField(300),
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            canRequestFocus: true,
                            cursorColor: MAIN_COLOR,
                            cursorRadius: Radius.circular(50.0),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: MAIN_COLOR),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 20.0),
                              labelText: 'Email',

                              prefixIcon: Icon(
                                Icons.email,
                                color: MAIN_COLOR,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.green[200]!,
                                  width: 1.5,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.green[50],
                              // Background color nhẹ
                              hintStyle: TextStyle(
                                color: Colors.green[200],
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.green[700]!,
                                  width: 2.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.redAccent, // Màu viền khi lỗi
                                  width: 1.5,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                  // Màu viền khi lỗi và được focus
                                  width: 2.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                gapPadding: 15,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40.0, top: 12),
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
                              labelText: 'Password',
                              prefixIcon: const Icon(
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
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.redAccent, // Màu viền khi lỗi
                                  width: 1.5,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                  // Màu viền khi lỗi và được focus
                                  width: 2.0,
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
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 50, top: 12, bottom: 25.0),
                              child: GestureDetector(
                                onTap: () => _gotoForgetPasswordPage(context),
                                child: Text(
                                  "Forget Password ",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: MAIN_COLOR,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 140.0),
                                backgroundColor: MAIN_TEXT_COLOR,
                                foregroundColor: Colors.white,
                                animationDuration: Duration(seconds: 2),
                                elevation: 4.0),
                            onPressed: () {
                              login(_formKey, context);
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: MAIN_COLOR),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 140.0),
                                backgroundColor: MAIN_TEXT_COLOR,
                                foregroundColor: Colors.white,
                                animationDuration: Duration(seconds: 2),
                                elevation: 4.0),
                            onPressed: () {
                              _gotoTest(context);
                            },
                            child: Text(
                              "Go to Test Page",
                              style: TextStyle(color: MAIN_COLOR),
                            )),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Or login with",
                          style: TextStyle(
                            color: MAIN_COLOR,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                                child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset(
                                "assets/fb-icon.png",
                                fit: BoxFit.cover,
                              ),
                            )),
                            const SizedBox(
                              width: 35,
                            ),
                            GestureDetector(
                              child: SizedBox(
                                height: 35,
                                width: 35,
                                child: Image.asset(
                                  "assets/gg-icon.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.asset(
                                  "assets/apple-icon.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Do not have an account ?",
                                  style: TextStyle(color: Colors.black87)),
                              GestureDetector(
                                  onTap: () {
                                    _gotoRegisterPage(context);
                                  },
                                  child: Text(" Sign up ",
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
