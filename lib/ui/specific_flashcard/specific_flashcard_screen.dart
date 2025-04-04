import 'dart:io';

import 'package:flashcard_learning/domain/models/Flashcard.dart';
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

enum TtsState { playing, stopped, paused, continued }

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
  Widget _buildBlackPage() {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            _showPopUp(true);
          },
          child: Text("Add Flashcard")),
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
        bool actionSuccessfully = await specificFlashCardViewModel
            .deleteACard(specificFlashCardViewModel.flashcardList[_index]);
        LoadingOverlay.hide();
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
                                    onPressed: () async {
                                      await deleteAFlashCard();
                                    },
                                    icon: Icon(CupertinoIcons.trash,
                                        size: 25, color: Color(0xff187ee1)),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await _speak(specificFlashCardViewModel
                                          .flashcardList[_index].english);
                                    },
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
