import 'package:flashcard_learning/domain/models/flashSet.dart';
import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';
import 'package:flashcard_learning/ui/flashcard_sets/widgets/CustomCardProvider.dart';
import 'package:flashcard_learning/ui/flashcard_sets/widgets/CustomIconPickerDialog.dart';
import 'package:flashcard_learning/ui/flashcard_sets/widgets/grid_item_widget.dart';
import 'package:flashcard_learning/utils/LoadingOverlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../utils/color/AllColor.dart';
import 'list_item_widget.dart';

class AllFlashCardSet extends StatefulWidget {
  const AllFlashCardSet({super.key});

  @override
  State<AllFlashCardSet> createState() => _AllFlashCardSetState();
}

class _AllFlashCardSetState extends State<AllFlashCardSet> {
  bool isGridView = true;
  Color mainColor = const Color(0xff3F2088);
  TextEditingController nameController = TextEditingController();
  List<FlashCardSet> flashcardSetList = [];

  TextFormField _buildTextFormEnglish(controller) {
    String typeWord = "";
    OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: MAIN_THEME_BLUE, width: 5),
    );
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: border,
        enabledBorder: border,
        border: const OutlineInputBorder(borderSide: BorderSide(width: 2)),
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        hintText: "Enter flashcard Set's name",
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      onChanged: (value) => typeWord = value,
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  late Future<void> _loadData;

  void _showPopUp() {
    Color pickedColor = MAIN_THEME_PURPLE;
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
            _buildTextFormEnglish(nameController),
            Consumer<CustomCardProvider>(
                builder: (context, colorProvider, child) {
              return const Customiconpickerdialog();
            }),
            SizedBox(
              height: 130,
              width: double.infinity,
              child: BlockPicker(
                  pickerColor: pickedColor,
                  onColorChanged: (color) {
                    pickedColor = color;
                    Provider.of<CustomCardProvider>(context, listen: false)
                        .changeColor(color);
                  }),
            ),
          ],
        ),
      ),
      onCancelBtnTap: () {
        context.pop();
      },
      onConfirmBtnTap: () async {
        if (nameController.text.isEmpty) {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Please input something',
          );

          return;
        }
        nameController.clear();
        LoadingOverlay.show(context);
        bool addedSuccessfully =
            await Provider.of<FlashCardSetViewModel>(context, listen: false)
                .addNewSet(FlashCardSet(
                    DateTime.now(),
                    nameController.text,
                    0,
                    0,
                    Provider.of<CustomCardProvider>(context, listen: false)
                        .iconData,
                    pickedColor));
        LoadingOverlay.hide();

        if (mounted) {
          context.pop();
          await QuickAlert.show(
            context: context,
            type: addedSuccessfully
                ? QuickAlertType.success
                : QuickAlertType.error,
            text: addedSuccessfully
                ? "Created new Flashcard Set"
                : "Failed to create Flashcard Set ",
          );
        }
      },
    );
  }

  void addFlashSet(BuildContext context) {
    _showPopUp();
  }

  void removeFlashcardSet() {}

  AppBar _buildAppbar() {
    return AppBar(
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
          child: Icon(CupertinoIcons.plus),
          onTap: () {
            addFlashSet(context);
          },
        ),
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
  void dispose() {
    super.dispose();
    nameController.dispose();
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
                  return isGridView
                      ? GridView.count(
                          crossAxisCount: 2,
                          children: flashCardSetViewModel.listFlashCardSets
                              .map((a) => Griditem(flashCardSet: a))
                              .toList(),
                        )
                      : ListView(
                          children: flashCardSetViewModel.listFlashCardSets
                              .map((a) => Listitem(flashCardSet: a))
                              .toList(),
                        );
                });
              }
            }));
  }
}
