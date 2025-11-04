import 'package:flashcard_learning/core/constants/app_icons.dart';
import 'package:flashcard_learning/domain/models/flashSet.dart';
import 'package:flashcard_learning/l10n/app_localization.dart';
import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';
import 'package:flashcard_learning/ui/flashcard_sets/widgets/CustomCardProvider.dart';
import 'package:flashcard_learning/ui/flashcard_sets/widgets/CustomIconPickerDialog.dart';
import 'package:flashcard_learning/ui/flashcard_sets/widgets/FlashCardSetItem.dart';
import 'package:flashcard_learning/utils/LoadingOverlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
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
  late Future<void> _loadFuture;

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
        hintText: context.l10n.myset_hint_enter_name,
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      onChanged: (value) => typeWord = value,
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

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
      cancelBtnText: context.l10n.myset_discard,
      showCancelBtn: true,
      cancelBtnTextStyle: TextStyle(color: Colors.redAccent, fontSize: 20),
      type: QuickAlertType.custom,
      barrierDismissible: true,
      confirmBtnText: context.l10n.myset_save,
      customAsset: 'assets/img-1.jpg',
      widget: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextFormEnglish(nameController),
            Consumer<CustomCardProvider>(
                builder: (context, customCardProvider, child) {
              return const CustomIconPickerDialog();
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
            text: context.l10n.myset_error_need_name,
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
                  IconMapper.toCode(customCardProvider.iconData ?? Icons.book),
                  customCardProvider.iconColor,
                  false));
        } else {
          actionSuccessfully = await flashCardSetViewModel.editASet(
              oldName,
              FlashCardSet(
                  nameController.text,
                  0,
                  IconMapper.toCode(customCardProvider.iconData ?? Icons.book),
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
                ? isCreating
                    ? context.l10n.myset_created_success
                    : context.l10n.myset_created_failed
                : isCreating
                    ? context.l10n.myset_updated_success
                    : context.l10n.myset_updated_failed,
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
      leading: BackButton(
        color: darkBlue,
      ),
      centerTitle: true,
      title: Text(
        context.l10n.myset_title,
        style: TextStyle(
            fontSize: 25,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            color: darkBlue),
      ),
      foregroundColor: mainColor,
      actions: [
        GestureDetector(
          child: Icon(
            CupertinoIcons.plus,
            color: darkBlue,
          ),
          onTap: () {
            addFlashSet(context);
          },
        ),
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
    _loadFuture = initializeLoadData();
  }

  Future<void> initializeLoadData() async {
    await context.read<FlashCardSetViewModel>().loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFuture = initializeLoadData();
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
      ..setIconData(IconMapper.fromCode(oldSet.iconData))
      ..setColor(oldSet.color);

    _showPopUp(false);
  }

  Future<void> deleteASet(String name) async {
    QuickAlert.show(
      context: context,
      cancelBtnText: context.l10n.myset_discard,
      showCancelBtn: true,
      cancelBtnTextStyle: TextStyle(color: Colors.blueGrey, fontSize: 20),
      type: QuickAlertType.custom,
      barrierDismissible: true,
      confirmBtnText: context.l10n.myset_delete_button,
      confirmBtnColor: Colors.red,
      customAsset: 'assets/img-1.jpg',
      widget: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          context.l10n.myset_delete_title,
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
                ? context.l10n.myset_created_success
                : context.l10n.myset_created_failed,
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
            // Icon lớn
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: const Text(
                "🎲",
                style: TextStyle(fontSize: 100),
              ),
            ),
            SizedBox(height: 25),
            // Tiêu đề
            Text(
              context.l10n.myset_blank_title,
              style: TextStyle(
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
            SizedBox(height: 15),
            // Mô tả
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                context.l10n.myset_blank_desc,
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
                context.l10n.myset_blank_btn,
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
            future: _loadFuture,
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
                                                isGridView: isGridView,
                                                isPublic: false,
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
                                                  deleteASet(a.name);
                                                },
                                                share: () {
                                                  shareASet(a);
                                                },
                                                isGridView: isGridView,
                                                isPublic: false,
                                              ))
                                          .toList(),
                                ))
                      : _buildBlankPage();
                });
              }
            }));
  }
}
