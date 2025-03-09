import 'package:flashcard_learning/domain/models/flashSet.dart';
import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';
import 'package:flashcard_learning/ui/flashcard_sets/widgets/CustomCardProvider.dart';
import 'package:flashcard_learning/ui/flashcard_sets/widgets/CustomIconPickerDialog.dart';
import 'package:flashcard_learning/ui/flashcard_sets/widgets/FlashCardSetItem.dart';
import 'package:flashcard_learning/utils/LoadingOverlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icon.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../utils/color/AllColor.dart';

class AllFlashCardPublicSet extends StatefulWidget {
  const AllFlashCardPublicSet({super.key});

  @override
  State<AllFlashCardPublicSet> createState() => _AllFlashCardSetPuclicState();
}

class _AllFlashCardSetPuclicState extends State<AllFlashCardPublicSet> {
  bool isGridView = false;
  Color mainColor = const Color(0xff3F2088);

  late Future<void> _loadData;

  AppBar _buildAppbar() {
    return AppBar(
      centerTitle: true,

      title: Text(
        "Flashcard Public",
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
            padding: const EdgeInsets.only(right: 30.0),
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
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData =
        Provider.of<FlashCardSetViewModel>(context, listen: false).loadData();
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
                          theme: PieTheme(
                            buttonSize: 45,
                            overlayColor: const Color(0x37BBA8FF).withOpacity(0.7),
                            rightClickShowsMenu: true,
                            tooltipTextStyle: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: isGridView
                              ? GridView.count(
                            crossAxisCount: 2,
                            children: flashCardSetViewModel.listFlashCardSets
                                .map((a) => FlashCardSetItem(
                              flashCardSet: a,
                              edit: () {
                              },
                              delete: () {
                              },
                              share: () {
                              },
                              isGridView: true,
                            ))
                                .toList(),
                          )
                              : ListView(
                            children: flashCardSetViewModel.listFlashCardSets
                                .map((a) => FlashCardSetItem(
                              flashCardSet: a,
                              edit: () {
                              },
                              delete: () {

                              },
                              share: () {
                              },
                              isGridView: false,
                            ))
                                .toList(),
                          ));
                    });
              }
            }));
  }
}
