import 'package:flashcard_learning/color/AllColor.dart';
import 'package:flashcard_learning/pages/OnboardPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/logo.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

  void _onBackToIntro(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnBoardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: MAIN_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logo(),
            Text(
              "Instilled with vocab, ready to break language barrier",
              textAlign: TextAlign.center,

              style: TextStyle(fontWeight: FontWeight.w500 ,color: Colors.white,
              fontSize: 25),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              height: MediaQuery.of(context).size.height - 150,
              decoration: BoxDecoration(
                  color: const Color(0xFFeaefee),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0))),
              child: Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                         left: 24.0, right: 24.0, bottom: 24.0),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 25.0),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 20.0),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          gapPadding: 15,
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 25.0),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      obscureText: true,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 5.0),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
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
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Text(
                          "Forget Password ",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: MAIN_COLOR,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      )),
                  ElevatedButton(onPressed: () {}, child: Text("Login")),
                  SizedBox(
                    height: 25,
                  ),
                  Text("Or login with"),
                  SizedBox(
                    height: 25,
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
                      SizedBox(
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
                      SizedBox(
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
                  SizedBox(
                    height: 25,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Do not have an account ?",
                          style: TextStyle(color: Colors.black87)),
                      TextSpan(
                          text: "Sign up ", style: TextStyle(color: MAIN_COLOR))
                    ]),
                  )
                ],
              )),
            )
          ],
        )),
      ),
    );
  }
}
