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

class AllFlashCardSet extends StatefulWidget {
  const AllFlashCardSet({super.key});

  @override
  State<AllFlashCardSet> createState() => _AllFlashCardSetState();
}

class _AllFlashCardSetState extends State<AllFlashCardSet> {
  bool isGridView = false;
  Color mainColor = const Color(0xff3F2088);
  TextEditingController nameController = TextEditingController();

  TextFormField _buildTextFormEnglish(controller) {
    String typeWord = "";
    OutlineInputBorder border = const OutlineInputBorder(
      borderSide: BorderSide(color: MAIN_THEME_BLUE, width: 5),
    );
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: border,
        enabledBorder: border,
        border: const OutlineInputBorder(borderSide: BorderSide(width: 2)),
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

  void _showPopUp(bool isCreating) {
    FlashCardSetViewModel flashCardSetViewModel =
        Provider.of<FlashCardSetViewModel>(context, listen: false);
    CustomCardProvider customCardProvider =
        Provider.of<CustomCardProvider>(context, listen: false);
    if (isCreating) {
      customCardProvider.setIconData(null);
    }
    String oldName = nameController.text;
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
                builder: (context, customCardProvider, child) {
              return Customiconpickerdialog();
            }),
            SizedBox(
              height: 130,
              width: double.infinity,
              child: BlockPicker(
                  pickerColor: customCardProvider.iconColor,
                  onColorChanged: (color) {
                    customCardProvider.setColor(color);
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
            text: 'Please input name of Set',
          );

          return;
        }

        LoadingOverlay.show(context);
        bool actionSuccessfully = false;
        if (isCreating) {
          actionSuccessfully = await flashCardSetViewModel.addNewSet(
              FlashCardSet(
                  DateTime.now(),
                  nameController.text,
                  0,
                  0,
                  customCardProvider.iconData ?? Icons.book,
                  customCardProvider.iconColor));
        } else {
          actionSuccessfully = await flashCardSetViewModel.editASet(
              flashCardSetViewModel.listFlashCardSets
                  .firstWhere((a) => a.name == oldName),
              FlashCardSet(
                  DateTime.now(),
                  nameController.text,
                  0,
                  0,
                  customCardProvider.iconData ?? Icons.book,
                  customCardProvider.iconColor));
        }

        LoadingOverlay.hide();
        nameController.clear();
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

  void addFlashSet(BuildContext context) {
    _showPopUp(true);
  }

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

  void editASet(FlashCardSet oldSet) {
    final customCardProvider =
        Provider.of<CustomCardProvider>(context, listen: false);
    nameController.text = oldSet.name;
    customCardProvider
      ..setIconData(oldSet.iconData)
      ..setColor(oldSet.color);

    _showPopUp(false);
  }

  void deleteASet(String name) {
    QuickAlert.show(
      context: context,
      cancelBtnText: "Discard",
      showCancelBtn: true,
      cancelBtnTextStyle: TextStyle(color: Colors.blueGrey, fontSize: 20),
      type: QuickAlertType.custom,
      barrierDismissible: true,
      confirmBtnText: 'Delete',
      confirmBtnColor: Colors.red,
      customAsset: 'assets/img-1.jpg',
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Are you sure to delete this set",
          style: TextStyle(color: Colors.blue, fontSize: 19),
          textAlign: TextAlign.center,
        ),
      ),
      onCancelBtnTap: () {
        context.pop();
      },
      onConfirmBtnTap: () async {
        LoadingOverlay.show(context);
        bool actionSuccessfully =
            await Provider.of<FlashCardSetViewModel>(context, listen: false)
                .deleteASet(name);
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

  void shareASet(FlashCardSet set) {
    Provider.of<FlashCardSetViewModel>(context, listen: false).shareNewSet(set);
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
                                          editASet(a);
                                        },
                                        delete: () {
                                          deleteASet(a.name);
                                        },
                                        share: () {
                                          shareASet(a);
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
                                          editASet(a);
                                        },
                                        delete: () {
                                          // showDialog(
                                          //     context: context,
                                          //     builder: (context) {
                                          //       return QuickAlert.show(context: context, type: type)
                                          //     });
                                          deleteASet(a.name);
                                        },
                                        share: () {
                                          shareASet(a);
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
