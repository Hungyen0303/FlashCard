import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../utils/LoadingOverlay.dart';
import '../../../../utils/color/AllColor.dart';
import '../../../../logo.dart';
import '../../login/view_models/login_viewmodel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = "nguyenvana@gmail.com";
    _usernameController.text = "testUser1";
    _passwordController.text = "123456";
    retypePasswordController.text = "123456";
  }

  Future<void> signUp(
      GlobalKey<FormState> formState, BuildContext context) async {
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    if (formState.currentState!.validate()) {
      LoadingOverlay.show(context);
      await loginViewModel.signUp(_emailController.text,
          _usernameController.text, _passwordController.text);
      if (mounted && !loginViewModel.hasError) {
        LoadingOverlay.hide();
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: "Register successfully",
            onConfirmBtnTap: () {
              // TODO : login
              context.go('/home');
            });
      } else if (mounted) {
        LoadingOverlay.hide();
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: loginViewModel.errorMessage,
            confirmBtnColor: Color(0xFFCB0606),
            confirmBtnTextStyle: TextStyle(
              color: Color(0xFFFFFFFF)
            ),
            onConfirmBtnTap: () {
              context.pop();
            });
        loginViewModel.hasError = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final ScrollController _scrollController = ScrollController();
    void scrollToFocusedField(double offset) {
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
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [COLOR_LOGIN_BACKGROUND, MAIN_COLOR])),
                child: const Column(
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
                    key: formKey,
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
                              "Sign Up ",
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
                            onTap: () => scrollToFocusedField(300),
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: MAIN_COLOR),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 20.0),
                              labelText: 'Email',
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40.0, top: 25.0),
                          child: TextFormField(
                            onTap: () => scrollToFocusedField(300),
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: _usernameController,
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
                              labelText: 'Username',

                              prefixIcon: Icon(
                                Icons.account_circle_sharp,
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
                              border: OutlineInputBorder(
                                gapPadding: 15,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40.0, top: 12),
                          child: TextFormField(
                            onTap: () => scrollToFocusedField(300),
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
                                return 'Please enter your password';
                              } else if (value.length < 6)
                                return 'Password must be at least 6 characters';
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40.0, top: 12, bottom: 25),
                          child: TextFormField(
                            onTap: () => scrollToFocusedField(300),
                            textAlign: TextAlign.left,
                            obscureText: true,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: retypePasswordController,
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
                              if (retypePasswordController.text.isEmpty) {
                                return 'Please enter your email';
                              } else if (value != _passwordController.text) {
                                return 'Confirmed password is not similar to password';
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
                            onPressed: () async {
                              await signUp(formKey, context);
                            },
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
