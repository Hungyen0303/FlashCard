import 'package:flashcard_learning/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo.png",
            height: 100,
          ),
          Text(
            "Flash Card Magic",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          )
        ],
      ),
    );
  }
}
