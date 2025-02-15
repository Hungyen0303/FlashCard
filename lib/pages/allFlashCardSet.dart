import 'dart:math';

import 'package:flashcard_learning/widgets/GridItem.dart';
import 'package:flashcard_learning/widgets/ListItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SpecificFlashCardPage.dart';

class AllFlashCardSet extends StatefulWidget {
  const AllFlashCardSet({super.key});

  @override
  State<AllFlashCardSet> createState() => _AllFlashCardSetState();
}

class _AllFlashCardSetState extends State<AllFlashCardSet> {
  Random _random = Random();
  bool isGridView = true;
  Color mainColor = Color(0xff3F2088);

  void _goToSpecificFlashCardSet(String nameOfSet) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SpecificFlashCardPage(
              nameOfSet: nameOfSet,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Flashcard",
          style: TextStyle(
              fontSize: 25,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              color: mainColor),
        ),
        foregroundColor: mainColor,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: isGridView
                  ? Icon(
                      Icons.list,
                    )
                  : Icon(Icons.grid_view_sharp),
            ),
            onTap: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),
      body: isGridView
          ? GridView.count(
              // Create a grid with 2 columns.
              // If you change the scrollDirection to horizontal,
              // this produces 2 rows.
              crossAxisCount: 2,
              // Generate 100 widgets that display their index in the list.
              children: List.generate(10, (index) {
                return Griditem(
                    name: "Flashcard Set $index",
                    numberOfCard: _random.nextInt(100),
                    minute: _random.nextInt(100),
                    onTap: () {
                      _goToSpecificFlashCardSet("Flashcard Set $index");
                    });
              }),
            )
          : ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Listitem(
                  name: "Flashcard Set $index",
                  onTap: () {},
                  minute: _random.nextInt(100),
                  numberOfCard: 50,
                );
              }),
    );
  }
}
