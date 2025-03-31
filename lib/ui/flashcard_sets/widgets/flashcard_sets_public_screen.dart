import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';

import 'package:flashcard_learning/ui/flashcard_sets/widgets/FlashCardSetItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:pie_menu/pie_menu.dart';
import 'package:provider/provider.dart';

import '../../../utils/color/AllColor.dart';

class AllFlashCardPublicSet extends StatefulWidget {
  const AllFlashCardPublicSet({super.key});

  @override
  State<AllFlashCardPublicSet> createState() => _AllFlashCardSetPublicState();
}

class _AllFlashCardSetPublicState extends State<AllFlashCardPublicSet> {
  bool isGridView = false;
  Color mainColor = const Color(0xff3F2088);

  late Future<void> _loadData;

  AppBar _buildAppbar() {
    return AppBar(
      leading: BackButton(
        color: darkBlue,
      ),
      centerTitle: true,
      title: Text(
        "Flashcard Public",
        style: TextStyle(
            fontSize: 22,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            color: darkBlue),
      ),
      foregroundColor: mainColor,
      actions: [

        GestureDetector(
          onTap: () {
            setState(() {
              isGridView = !isGridView;
            });
          },
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(isGridView ? Icons.list : Icons.grid_view_sharp,
                  color: darkBlue)),
        ),
      ],
    );
  }


  @override
  void initState() {
    super.initState();
    _loadData =
        Provider.of<FlashCardSetViewModel>(context, listen: false).loadDataPublic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbar(),
        body: FutureBuilder(
            future: _loadData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitFadingFour(
                    color: Colors.grey,
                  ),
                );
              } else {
                return Consumer<FlashCardSetViewModel>(
                    builder: (context, flashCardSetViewModel, child) {
                  return PieCanvas(
                      child: isGridView
                          ? GridView.count(
                              crossAxisCount: 2,
                              children:
                                  flashCardSetViewModel.listFlashCardSetsPublic
                                      .map((a) => FlashCardSetItem(
                                            isPublic: true,
                                            flashCardSet: a,
                                            edit: () {},
                                            delete: () {},
                                            share: () {},
                                            isGridView: true,
                                          ))
                                      .toList(),
                            )
                          : ListView(
                              children:
                                  flashCardSetViewModel.listFlashCardSetsPublic
                                      .map((a) => FlashCardSetItem(
                                            isPublic: true,
                                            flashCardSet: a,
                                            edit: () {},
                                            delete: () {},
                                            share: () {},
                                            isGridView: false,
                                          ))
                                      .toList(),
                            ));
                });
              }
            }));
  }
}
