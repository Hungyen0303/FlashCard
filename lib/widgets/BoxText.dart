import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Boxtext extends StatelessWidget {
  const Boxtext({super.key, required this.word, required this.ontap});

  final String word;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap() ,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        child: Text(
          word,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
