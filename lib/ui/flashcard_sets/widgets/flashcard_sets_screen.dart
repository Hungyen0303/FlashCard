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
import 'package:line_icons/line_icons.dart';
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
        context.read<FlashCardSetViewModel>();
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
                  nameController.text,
                  0,
                  customCardProvider.iconData ?? Icons.book,
                  customCardProvider.iconColor,
                  false));
        } else {
          actionSuccessfully = await flashCardSetViewModel.editASet(
              oldName,
              FlashCardSet(
                  nameController.text,
                  0,
                  customCardProvider.iconData ?? Icons.book,
                  customCardProvider.iconColor,
                  false));
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
    _loadData = context.read<FlashCardSetViewModel>().loadData();
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

  Future<void> deleteASet(String name) async {
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
            await context.read<FlashCardSetViewModel>().deleteASet(name);
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

  Widget _buildBlankPage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFDFFFF),
            Color(0xFFF8F8F8),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon lớn
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: Icon(
                LineIcons.bookOpen,
                size: 120,
                color: Colors.yellowAccent.withOpacity(0.9),
              ),
            ),
            SizedBox(height: 25),
            // Tiêu đề
            Text(
              "No Flashcard Sets Yet",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.yellowAccent,
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
            SizedBox(height: 15),
            // Mô tả
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Start your learning journey by creating your first flashcard set!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 35),
            // Nút tạo mới
            ElevatedButton.icon(
              onPressed: () {
                addFlashSet(context); // Gọi hàm tạo flashcard set
              },
              icon: Icon(CupertinoIcons.plus_circle_fill, size: 26),
              label: Text(
                "Create New Set",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF123456),
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 6,
                shadowColor: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
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
                  return flashCardSetViewModel.listFlashCardSets.isNotEmpty
                      ? PieCanvas(
                          theme: PieTheme(
                            buttonSize: 45,
                            overlayColor:
                                const Color(0x37BBA8FF).withOpacity(0.7),
                            rightClickShowsMenu: true,
                            tooltipTextStyle: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: isGridView
                              ? GridView.count(
                                  crossAxisCount: 2,
                                  children:
                                      flashCardSetViewModel.listFlashCardSets
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
                                  children:
                                      flashCardSetViewModel.listFlashCardSets
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
                                ))
                      : _buildBlankPage();
                });
              }
            }));
  }
}
