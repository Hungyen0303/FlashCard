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
import 'package:go_router/go_router.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class SpecificFlashCardPage extends StatefulWidget {
  const SpecificFlashCardPage({super.key, required this.nameOfSet});

  final String nameOfSet;

  @override
  State<SpecificFlashCardPage> createState() => _SpecificFlashCardPageState();
}

class _SpecificFlashCardPageState extends State<SpecificFlashCardPage> {
  TextFormField _buildTextFormEnglish() {
    String typeWord = "";
    OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: MAIN_THEME_BLUE, width: 5),
    );
    return TextFormField(
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

  void _showPopUp() {
    String message = "123";
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
            SizedBox(
              height: 10,
            ),
            _buildTextFormVietnamese(),
            SizedBox(
              height: 10,
            ),
            _buildTextFormExample(),
          ],
        ),
      ),
      onCancelBtnTap: () {
        context.pop();
      },
      onConfirmBtnTap: () async {
        if (message.length < 5) {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Please input something',
          );
          return;
        }
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 1000));
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: "Phone number '$message' has been saved!.",
        );
      },
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text("${widget.nameOfSet}"),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () => _showPopUp(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(CupertinoIcons.plus),
          ),
        )
      ],
    );
  }

  List<FlashCard> flashCards = [];

  @override
  void initState() {
    super.initState();
  }

  Alignment positionNearTop = const Alignment(0, -0.5);
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

  Future<List<FlashCard>> getAll() async {
    SpecificFlashCardViewModel specificFlashCardViewModel =
        SpecificFlashCardViewModel();
    return await specificFlashCardViewModel.getAll();
  }

  final controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
        appBar: _buildAppbar(),
        body: FutureBuilder(
            future: getAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinKitFadingFour(
                  color: Colors.grey,
                );
              } else {
                flashCards = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Color(0xffeee880),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("${_index + 1} / ${flashCards.length}"),
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
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  axis: FlipAxis.horizontal,
                                  enableController: false,
                                  // if [True] if you need flip the card using programmatically
                                  frontWidget:
                                      _buildCard(flashCards[_index].english),
                                  backWidget: _buildCard(
                                      flashCards[_index].vietnamese)),
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
                              if (_index == flashCards.length - 1) {
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
            }));
  }
}
