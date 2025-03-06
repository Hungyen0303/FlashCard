import 'package:flashcard_learning/domain/models/Flashcard.dart';
import 'package:flashcard_learning/routing/router.dart';
import 'package:flashcard_learning/ui/specific_flashcard/view_models/SpecificFlashCardViewModel.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'dart:math';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../utils/LoadingOverlay.dart';

class SpecificFlashCardPage extends StatefulWidget {
  const SpecificFlashCardPage({super.key, required this.nameOfSet});

  final String nameOfSet;

  @override
  State<SpecificFlashCardPage> createState() => _SpecificFlashCardPageState();
}

class _SpecificFlashCardPageState extends State<SpecificFlashCardPage> {
  Alignment positionNearTop = const Alignment(0, -0.5);
  int _index = 0;
  late Future<void> loadData;
  TextEditingController vietnamese = TextEditingController();
  TextEditingController english = TextEditingController();
  TextEditingController example = TextEditingController();
  bool showExample = false;

  TextFormField _buildTextFormEnglish() {
    String typeWord = "";
    OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: MAIN_THEME_BLUE, width: 5),
    );
    return TextFormField(
      controller: english,
      decoration: InputDecoration(
        focusedBorder: border,
        enabledBorder: border,
        border: const OutlineInputBorder(borderSide: BorderSide(width: 2)),
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        hintText: 'Enter English word',
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      onChanged: (value) => typeWord = value,
    );
  }

  TextFormField _buildTextFormVietnamese() {
    String typeWord = "";

    OutlineInputBorder border = OutlineInputBorder(
        borderSide: BorderSide(color: MAIN_THEME_YELLOW, width: 5));
    return TextFormField(
      controller: vietnamese,
      decoration: InputDecoration(
        focusedBorder: border,
        enabledBorder: border,
        border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        hintText: 'Enter Vietnamese word',
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      onChanged: (value) => typeWord = value,
    );
  }

  TextFormField _buildTextFormExample() {
    String typeWord = "";
    OutlineInputBorder border = OutlineInputBorder(
        borderSide: BorderSide(color: MAIN_THEME_PURPLE, width: 5));
    return TextFormField(
      controller: example,
      minLines: 2,
      maxLines: 5,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border,
        border: const OutlineInputBorder(borderSide: BorderSide(width: 2)),
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        hintText: 'Enter example',
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      onChanged: (value) => typeWord = value,
    );
  }

  void _showPopUp(bool isCreating) {
    SpecificFlashCardViewModel specificFlashCardViewModel =
        Provider.of<SpecificFlashCardViewModel>(context, listen: false);

    if (isCreating) {
      vietnamese.clear();
      english.clear();
      example.clear();
    } else {
      vietnamese.text =
          specificFlashCardViewModel.flashcardList[_index].vietnamese;
      english.text = specificFlashCardViewModel.flashcardList[_index].english;
      example.text = specificFlashCardViewModel.flashcardList[_index].example;
      print(vietnamese.text);
    }
    QuickAlert.show(
      context: context,
      cancelBtnText: "Discard",
      showCancelBtn: true,
      cancelBtnTextStyle: TextStyle(color: Colors.redAccent, fontSize: 20),
      type: QuickAlertType.custom,
      barrierDismissible: true,
      confirmBtnText: 'Save',
      customAsset: 'assets/img-1.jpg',
      widget: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextFormEnglish(),
            _buildTextFormVietnamese(),
            _buildTextFormExample(),
          ],
        ),
      ),
      onCancelBtnTap: () {
        context.pop();
      },
      onConfirmBtnTap: () async {
        if (vietnamese.text.isEmpty || english.text.isEmpty) {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Please input both English and Vietnamese',
          );

          return;
        }

        LoadingOverlay.show(context);
        bool actionSuccessfully = false;
        if (isCreating) {
          actionSuccessfully = await specificFlashCardViewModel
              .addACard(FlashCard(english.text, vietnamese.text, example.text));
        } else {
          actionSuccessfully = await specificFlashCardViewModel.editACard(
              specificFlashCardViewModel.flashcardList[_index],
              FlashCard(english.text, vietnamese.text, example.text));
        }
        LoadingOverlay.hide();

        if (mounted) {
          context.pop();
          await QuickAlert.show(
            context: context,
            type: actionSuccessfully
                ? QuickAlertType.success
                : QuickAlertType.error,
            text: actionSuccessfully
                ? "Created new Flashcard Set"
                : "Failed to create Flashcard Set ",
          );
        }
      },
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text("${widget.nameOfSet}"),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () => _showPopUp(true),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(CupertinoIcons.plus),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    loadData = Provider.of<SpecificFlashCardViewModel>(context, listen: false)
        .getAll(widget.nameOfSet);
  }

  @override
  void dispose() {
    super.dispose();
    vietnamese.dispose();
    english.dispose();
    example.dispose();
  }

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

  // page when there is no flashcard
  Widget _buildBlackPage() {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            _showPopUp(true);
          },
          child: Text("Add Flashcard")),
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
        appBar: _buildAppbar(),
        body: FutureBuilder(
            future: loadData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SpinKitFadingFour(
                  color: Colors.grey,
                );
              } else {
                return Consumer<SpecificFlashCardViewModel>(
                    builder: (context, specificFlashCardViewModel, child) {
                  return specificFlashCardViewModel.flashcardList.isEmpty
                      ? _buildBlackPage()
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: const Color(0xffeee880),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                    "${_index + 1} / ${specificFlashCardViewModel.flashcardList.length}"),
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
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: GestureFlipCard(
                                          animationDuration:
                                              const Duration(milliseconds: 300),
                                          axis: FlipAxis.horizontal,
                                          enableController: false,
                                          // if [True] if you need flip the card using programmatically
                                          frontWidget: _buildCard(
                                              specificFlashCardViewModel
                                                  .flashcardList[_index]
                                                  .english),
                                          backWidget: _buildCard(
                                              specificFlashCardViewModel
                                                  .flashcardList[_index]
                                                  .vietnamese)),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 120,
                              ),
                              Visibility(
                                  visible: !showExample,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xffFF7E5F),
                                              Color(0xfff67916)
                                            ])),
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            showExample = !showExample;
                                          });
                                        },
                                        child: const Text(
                                          "View Example",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  )),
                              Visibility(
                                  visible: showExample,
                                  child: Text(
                                    specificFlashCardViewModel
                                        .flashcardList[_index].example,
                                    style: TextStyle(
                                        color: Color(0xFFF10808), fontSize: 20),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      specificFlashCardViewModel.deleteACard(
                                          specificFlashCardViewModel
                                              .flashcardList[_index]);
                                    },
                                    icon: Icon(CupertinoIcons.trash,
                                        size: 25, color: Color(0xff187ee1)),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.volume_up,
                                      size: 25,
                                      color: Color(0xff609fde),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _showPopUp(false);
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.penToSquare,
                                      size: 25,
                                      color: Color(0xff609fde),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (_index == 0) {
                                        return;
                                      }
                                      setState(() {
                                        _index--;
                                        if (showExample)
                                          showExample = !showExample;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.navigate_before,
                                      size: 25,
                                      color: Color(0xff609fde),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (_index ==
                                          specificFlashCardViewModel
                                                  .flashcardList.length -
                                              1) {
                                        return;
                                      }
                                      setState(() {
                                        _index++;
                                        if (showExample)
                                          showExample = !showExample;
                                      });
                                    },
                                    icon: Icon(
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
                });
              }
            }));
  }
}
