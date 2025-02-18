import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'dart:math';

import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';

class SpecificFlashCardPage extends StatefulWidget {
  const SpecificFlashCardPage({super.key, required this.nameOfSet});

  final nameOfSet;

  @override
  State<SpecificFlashCardPage> createState() => _SpecificFlashCardPageState();
}

class _SpecificFlashCardPageState extends State<SpecificFlashCardPage> {
  AppBar _buildAppbar() {
    return AppBar(
      title: Text("${widget.nameOfSet}"),
      centerTitle: true,
    );
  }

  Alignment positionNearTop = const Alignment(0, -0.5);

  List<Map<String, String>> flashcards = [
    {"Word": "Từ chữ "},
    {"Hello": "Xin chào "},
    {"Goodbye": "Tạm biệt"}
  ];

  int _index = 0;

  Container _buildCard(String word) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent, // Nền màu xanh
        borderRadius: BorderRadius.circular(20), // Bo tròn góc
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          // Tạo gradient cho foreground
          colors: [Colors.white.withOpacity(0.2), Colors.transparent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20), // Bo tròn giống như decoration
      ),
      child: Center(
        child: Text(
          word,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  final controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: _buildAppbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                color: Color(0xffeee880),
                borderRadius: BorderRadius.circular(10)),
            child: Text("${_index + 1} / ${flashcards.length}"),
          ),
          SizedBox(
            height: 50,
          ),
          Align(
            alignment: positionNearTop,
            child: Stack(
              children: [
                Transform.rotate(
                  angle: -15 * (pi / 180),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: Color(0xff83dfc2),
                      borderRadius: BorderRadius.circular(
                          20), // Bo tròn giống như decoration
                    ),
                  ),
                ),
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        20), // Bo tròn giống như decoration
                  ),
                  child: GestureFlipCard(
                      animationDuration: const Duration(milliseconds: 300),
                      axis: FlipAxis.horizontal,
                      enableController: false,
                      // if [True] if you need flip the card using programmatically
                      frontWidget: _buildCard(flashcards[_index].keys.first),
                      backWidget: _buildCard(flashcards[_index].values.first)),
                )
              ],
            ),
          ),
          SizedBox(
            height: 120,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                CupertinoIcons.trash,
                size: 25,
                color: Color(0xff609fde),
              ),
              Icon(
                Icons.volume_up,
                size: 25,
                color: Color(0xff609fde),
              ),
              GestureDetector(
                onTap: () {
                  if (_index == 0) {
                    return;
                  }
                  setState(() {
                    _index--;
                  });
                },
                child: Icon(
                  Icons.navigate_before,
                  size: 25,
                  color: Color(0xff609fde),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_index == flashcards.length - 1) {
                    return;
                  }
                  setState(() {
                    _index++;
                  });
                },
                child: Icon(
                  Icons.navigate_next,
                  size: 25,
                  color: Color(0xff609fde),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
