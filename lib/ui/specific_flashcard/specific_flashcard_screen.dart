import 'dart:io';

import 'package:flashcard_learning/domain/models/Flashcard.dart';
import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';
import 'package:flashcard_learning/ui/specific_flashcard/view_models/SpecificFlashCardViewModel.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'dart:math';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../utils/LoadingOverlay.dart';
import '../account/account_viewmodel.dart';

enum TtsState { playing, stopped, paused, continued }

class SpecificFlashCardPage extends StatefulWidget {
  const SpecificFlashCardPage(
      {super.key, required this.nameOfSet, required this.isPublic});

  final String nameOfSet;
  final bool isPublic;

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
            SizedBox(
              height: 5,
            ),
            _buildTextFormVietnamese(),
            SizedBox(
              height: 5,
            ),
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
          actionSuccessfully = await specificFlashCardViewModel.addACard(
              FlashCard(english.text, vietnamese.text, example.text),
              widget.nameOfSet);
        } else {
          actionSuccessfully = await specificFlashCardViewModel.editACard(
              specificFlashCardViewModel.flashcardList[_index],
              FlashCard(english.text, vietnamese.text, example.text),
              widget.nameOfSet);
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
                ? "Created new Flashcard "
                : "Failed to create Flashcard  ",
          );
        }
      },
    );
  }

  static const Color primaryColor = Color(0xFF4361EE);
  static const Color secondaryColor = Color(0xFF3A0CA3);
  static const Color accentColor = Color(0xFF7209B7);
  static const Color successColor = Color(0xFF4BB543);
  static const Color warningColor = Color(0xFFFFCC00);
  static const Color dangerColor = Color(0xFFCC0000);

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        widget.nameOfSet,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: primaryColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        if (!widget.isPublic)
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _showPopUp(true),
          ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    final specificFlashCardViewModel =
        Provider.of<SpecificFlashCardViewModel>(context, listen: false);
    final accountViewModel =
        Provider.of<AccountViewModel>(context, listen: false);

    specificFlashCardViewModel.onDoneChanged = (num) {
      accountViewModel.changeNumOfCompleteFlashcard(num);
    };
    loadData =
        context.read<SpecificFlashCardViewModel>().loadData(widget.nameOfSet);
    initTts();
  }

  @override
  void dispose() {
    super.dispose();
    vietnamese.dispose();
    english.dispose();
    example.dispose();
    flutterTts.stop();
  }

  Widget _buildCard(String text) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, secondaryColor],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  final controller = FlipCardController();

  /* FLUTTER TEXT TO SPEECH */
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;
  int? _inputLength;

  TtsState ttsState = TtsState.stopped;

  bool get isPlaying => ttsState == TtsState.playing;

  bool get isStopped => ttsState == TtsState.stopped;

  bool get isPaused => ttsState == TtsState.paused;

  bool get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  bool get isWindows => !kIsWeb && Platform.isWindows;

  bool get isWeb => kIsWeb;

  dynamic initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        print("Paused");
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<dynamic> _getLanguages() async => await flutterTts.getLanguages;

  Future<dynamic> _getEngines() async => await flutterTts.getEngines;

  Future<void> _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print("Engine is $engine");
    }
  }

  Future<void> _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print("getDefaultVoice $voice");
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    await flutterTts.speak(text);
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future<void> _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  List<DropdownMenuItem<String>> getEnginesDropDownMenuItems(
      List<dynamic> engines) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in engines) {
      items.add(DropdownMenuItem(
          value: type as String?, child: Text((type as String))));
    }
    return items;
  }

  void changedEnginesDropDownItem(String? selectedEngine) async {
    await flutterTts.setEngine(selectedEngine!);
    language = null;
    setState(() {
      engine = selectedEngine;
    });
  }

  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
      List<dynamic> languages) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in languages) {
      items.add(DropdownMenuItem(
          value: type as String?, child: Text((type as String))));
    }
    return items;
  }

  void changedLanguageDropDownItem(String? selectedType) {
    setState(() {
      language = selectedType;
      flutterTts.setLanguage(language!);
      if (isAndroid) {
        flutterTts
            .isLanguageInstalled(language!)
            .then((value) => isCurrentLanguageInstalled = (value as bool));
      }
    });
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }

  Widget _engineSection() {
    if (isAndroid) {
      return FutureBuilder<dynamic>(
          future: _getEngines(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return _enginesDropDownSection(snapshot.data as List<dynamic>);
            } else if (snapshot.hasError) {
              return Text('Error loading engines...');
            } else {
              return Text('Loading engines...');
            }
          });
    } else {
      return Container(width: 0, height: 0);
    }
  }

  Widget _futureBuilder() => FutureBuilder<dynamic>(
      future: _getLanguages(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _languageDropDownSection(snapshot.data as List<dynamic>);
        } else if (snapshot.hasError) {
          return Text('Error loading languages...');
        } else
          return Text('Loading Languages...');
      });

  Widget _inputSection() => Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
      child: TextField(
        maxLines: 11,
        minLines: 6,
        onChanged: (String value) {
          _onChange(value);
        },
      ));

  Widget _btnSection() {
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Colors.green, Colors.greenAccent, Icons.play_arrow,
              'PLAY', _speak),
          _buildButtonColumn(
              Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
          _buildButtonColumn(
              Colors.blue, Colors.blueAccent, Icons.pause, 'PAUSE', _pause),
        ],
      ),
    );
  }

  Widget _enginesDropDownSection(List<dynamic> engines) => Container(
        padding: EdgeInsets.only(top: 50.0),
        child: DropdownButton(
          value: engine,
          items: getEnginesDropDownMenuItems(engines),
          onChanged: changedEnginesDropDownItem,
        ),
      );

  Widget _languageDropDownSection(List<dynamic> languages) => Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
          value: language,
          items: getLanguageDropDownMenuItems(languages),
          onChanged: changedLanguageDropDownItem,
        ),
        Visibility(
          visible: isAndroid,
          child: Text("Is installed: $isCurrentLanguageInstalled"),
        ),
      ]));

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: color)))
        ]);
  }

  Widget _getMaxSpeechInputLengthSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: Text('Get max speech input length'),
          onPressed: () async {
            _inputLength = await flutterTts.getMaxSpeechInputLength;
            setState(() {});
          },
        ),
        Text("$_inputLength characters"),
      ],
    );
  }

  Widget _buildSliders() {
    return Column(
      children: [_volume(), _pitch(), _rate()],
    );
  }

  Widget _volume() {
    return Slider(
        value: volume,
        onChanged: (newVolume) {
          setState(() => volume = newVolume);
        },
        min: 0.0,
        max: 1.0,
        divisions: 10,
        label: "Volume: ${volume.toStringAsFixed(1)}");
  }

  Widget _pitch() {
    return Slider(
      value: pitch,
      onChanged: (newPitch) {
        setState(() => pitch = newPitch);
      },
      min: 0.5,
      max: 2.0,
      divisions: 15,
      label: "Pitch: ${pitch.toStringAsFixed(1)}",
      activeColor: Colors.red,
    );
  }

  Widget _rate() {
    return Slider(
      value: rate,
      onChanged: (newRate) {
        setState(() => rate = newRate);
      },
      min: 0.0,
      max: 1.0,
      divisions: 10,
      label: "Rate: ${rate.toStringAsFixed(1)}",
      activeColor: Colors.green,
    );
  }

  /* FLUTTER TEXT TO SPEECH */
  // page when there is no flashcard
  Widget _buildBlankPage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF082D4F), Color(0xFFE7D9C8)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon lớn với animation
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 1000),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                child: Icon(
                  CupertinoIcons.square_stack_3d_up_fill,
                  size: 120,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            SizedBox(height: 25),
            // Tiêu đề
            Text(
              "No Flashcards Here",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Get started by adding your first flashcard to '${widget.nameOfSet}'!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 35),
            // Nút thêm flashcard
            ElevatedButton.icon(
              onPressed: () {
                _showPopUp(true); // Gọi hàm thêm flashcard mới
              },
              icon: Icon(
                CupertinoIcons.plus_circle_fill,
                size: 26,
                color: Color(0xFF123456),
              ),
              label: Text(
                "Add First Flashcard",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF123456)),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: MAIN_THEME_YELLOW,
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

  Future<void> deleteAFlashCard() async {
    SpecificFlashCardViewModel specificFlashCardViewModel =
        Provider.of<SpecificFlashCardViewModel>(context, listen: false);
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
          "Are you sure to delete this word",
          style: TextStyle(color: Colors.blue, fontSize: 19),
          textAlign: TextAlign.center,
        ),
      ),
      onCancelBtnTap: () {
        context.pop();
      },
      onConfirmBtnTap: () async {
        LoadingOverlay.show(context);
        bool actionSuccessfully = await specificFlashCardViewModel.deleteACard(
            specificFlashCardViewModel.flashcardList[_index], widget.nameOfSet);
        LoadingOverlay.hide();
        setState(() {
          if (_index >= 1) {
            _index--;
          }
        });
        if (mounted) {
          context.pop();
          await QuickAlert.show(
            context: context,
            type: actionSuccessfully
                ? QuickAlertType.success
                : QuickAlertType.error,
            text: actionSuccessfully
                ? "Deleted a Flashcard !! "
                : "Failed to delete ",
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SpecificFlashCardViewModel>(context);
    final flashcardList = viewModel.flashcardList;
    final currentFlashcard =
        _index < flashcardList.length ? flashcardList[_index] : null;

    return Scaffold(
      appBar: _buildAppBar(),
      body: flashcardList.isEmpty
          ? _buildBlankPage()
          : Column(
              children: [
                // Progress indicator
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: LinearProgressIndicator(
                    value: (_index + 1) / flashcardList.length,
                    backgroundColor: Colors.grey[200],
                    color: primaryColor,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Flashcard counter
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Card ${_index + 1} of ${flashcardList.length}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      if (!widget.isPublic)
                        IconButton(
                          icon: Icon(
                            currentFlashcard?.done ?? false
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            color: currentFlashcard?.done ?? false
                                ? successColor
                                : Colors.grey,
                          ),
                          onPressed: () => viewModel.markDone(_index),
                        ),
                    ],
                  ),
                ),
                // Flashcard
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureFlipCard(
                      animationDuration: const Duration(milliseconds: 400),
                      frontWidget: _buildCard(currentFlashcard?.english ?? ""),
                      backWidget:
                          _buildCard(currentFlashcard?.vietnamese ?? ""),
                    ),
                  ),
                ),
                // Example sentence
                if (showExample && currentFlashcard?.example.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Example:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              currentFlashcard!.example,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                // Control buttons
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: primaryColor,
                        iconSize: 30,
                        onPressed: () async {
                          await deleteAFlashCard();
                        },
                      ),
                      if (!widget.isPublic)
                        IconButton(
                          icon: const Icon(Icons.edit),
                          color: primaryColor,
                          iconSize: 30,
                          onPressed: () {
                            _showPopUp(false);
                          },
                        ),
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: _index == 0 ? Colors.grey : primaryColor,
                        iconSize: 30,
                        onPressed: _index == 0
                            ? null
                            : () {
                                setState(() {
                                  _index--;
                                  showExample = false;
                                });
                              },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showExample = !showExample;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              showExample ? Colors.grey : primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          showExample ? "Hide Example" : "Show Example",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        color: _index == flashcardList.length - 1
                            ? Colors.grey
                            : primaryColor,
                        iconSize: 30,
                        onPressed: _index == flashcardList.length - 1
                            ? null
                            : () {
                                setState(() {
                                  _index++;
                                  showExample = false;
                                });
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
