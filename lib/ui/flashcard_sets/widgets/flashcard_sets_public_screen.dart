import 'package:flashcard_learning/l10n/app_localization.dart';
import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';

import 'package:flashcard_learning/ui/flashcard_sets/widgets/FlashCardSetItem.dart';
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
      leading: const BackButton(
        color: darkBlue,
      ),
      centerTitle: true,
      title: Text(
        context.l10n.public_flashcard_title,
        style: const TextStyle(
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

  Widget _buildBlankPage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF529CE5),
            Color(0xFF86B3E0),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: const Text(
                "🎲",
                style: TextStyle(fontSize: 100),
              ),
            ),
            SizedBox(height: 25),
            Text(
              context.l10n.public_flashcard_no_sets,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: white,
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    color: Colors.black45,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                context.l10n.public_flashcard_no_sets_desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData = Provider.of<FlashCardSetViewModel>(context, listen: false)
        .loadDataPublic();
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
                      child: flashCardSetViewModel
                              .listFlashCardSetsPublic.isNotEmpty
                          ? isGridView
                              ? GridView.count(
                                  crossAxisCount: 2,
                                  children: flashCardSetViewModel
                                      .listFlashCardSetsPublic
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
                                  children: flashCardSetViewModel
                                      .listFlashCardSetsPublic
                                      .map((a) => FlashCardSetItem(
                                            isPublic: true,
                                            flashCardSet: a,
                                            edit: () {},
                                            delete: () {},
                                            share: () {},
                                            isGridView: false,
                                          ))
                                      .toList(),
                                )
                          : _buildBlankPage());
                });
              }
            }));
  }
}
