import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/badges_model.dart';
import 'package:cardflip/models/test_model.dart';
import 'package:cardflip/widgets/badges/badges.dart';
import 'package:cardflip/widgets/flashcards/card_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as developer;
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:date_time_format/date_time_format.dart';
import 'dart:core';

class Test extends ConsumerStatefulWidget {
  Deck deck;
  Test({super.key, required this.deck});

  @override
  ConsumerState<Test> createState() => _TestState();
}

class _TestState extends ConsumerState<Test>
    with SingleTickerProviderStateMixin {
  bool continuetimer = true;
  Stream<int>? stopwatch;
  StreamSubscription<int>? stopwatchsubscrip;
  String min = "0";
  String sec = "00";
  late BoxDecoration status;
  late TestModel model;
  late BadgesModel badge;
  late Map testCards;
  late List definitions = [];
  late List terms = [];
  late List correctAnswers = [];
  late bool? isCorrect;
  late List<List<bool?>> jiggle = [];
  final animduration = const Duration(milliseconds: 450);
  List<double> start = [];
  List<double> end = [];
  int i = 0;
  var random = [0, 1, 2];
  late List<List<int>> randomlist;
  var testCardsList = [];
  late List<bool> isActive = [];
  late bool viable;
  bool missed = false;
  List missedCards = [];
  Map wrongCards = {};
  Future<Map<String, bool>> badgecheck = Future.value({});
  var timeTaken;
  var seconds;
  bool gotData = false;
  String background = "Images/backgrounds/testpage.png";
  // String background = "Images/backgrounds/finaltest.png";
  // ugly all red or all pink

// sh then set then use then remove
  Stream<int> stopWatch() {
    StreamController<int>? controller;
    Timer? timer;
    Duration duration = const Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer!.cancel();
        timer = null;
        counter = 0;
        controller!.close();
      }
    }

    void tick(_) {
      counter++;
      controller!.add(counter);
      if (!continuetimer) {
        stopTimer();
      }
    }

    void startTimer() {
      timer = Timer.periodic(duration, tick);
    }

    void pauseTimer() {
      if (timer != null) {
        timeTaken = DateTimeFormat.relative(DateTime.now().subtract(
            Duration(minutes: int.parse(min), seconds: int.parse(sec))));
        seconds = Duration(minutes: int.parse(min)).inSeconds + int.parse(sec);

        // timer!.cancel();
        // timer = null;
      }
    }

    controller = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: pauseTimer,
    );
    return controller.stream;
  }

  @override
  void initState() {
    model = TestModel(deck: widget.deck);
    testCards = model.getTestCards;
    testCards.forEach((d, t) => testCardsList.add([d, t[0], t[1], t[2]]));

    testCardsList.shuffle();

    testCardsList.forEach((element) {
      definitions.add(element[0]);
    });

    testCardsList.forEach((element) {
      terms.add([element[1], element[2], element[3]]);
    });

    random.shuffle();
    randomlist = List.filled(definitions.length, [0, 1, 2]);
    randomlist = randomize(definitions.length);

    start = List.filled(definitions.length, 0.0);
    end = List.filled(definitions.length, 0.0);
    isActive = List.filled(definitions.length, false);
    isActive[0] = true;
    stopwatch = stopWatch();
    jiggle = List.filled(definitions.length, List.filled(3, null));
    stopwatchsubscrip = stopwatch!.listen((int tick) {
      setState(() {
        min = ((tick / 60) % 60).floor().toString();
        sec = (tick % 60).floor().toString().padLeft(2, '0');
      });
    });

    status = BoxDecoration(
      border: Border.all(
        color: const Color.fromARGB(71, 36, 0, 0),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(16),
      color: const Color(0x40fff4f4),
    );
    // }
    super.initState();
  }

  List<List<int>> randomize(int size) {
    for (int i = 0; i < size; i++) {
      random.shuffle();
      randomlist[i] = [...random];
    }
    return randomlist;
  }

  BoxDecoration checkBox(bool? isCorrect) {
    BoxDecoration status;
    (isCorrect == true)
        ? status = BoxDecoration(
            border: Border.all(
              color: const Color(0xB393FF97),
              width: 3,
            ),
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromARGB(175, 217, 255, 218),
          )
        : (isCorrect == false)
            ? status = BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(130, 217, 0, 0),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(16),
                color: Color.fromARGB(123, 255, 255, 255))
            : status = BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(71, 36, 0, 0),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
                color: Color(0x40fff4f4),
              );
    return status;
  }

// ugly all red or all pink
  @override
  Future<void> setState(VoidCallback fn) async {
    if (i >= definitions.length)
      background = 'Images/backgrounds/finaltest.png';
    super.setState(fn);
  }

  _TestState({key});

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(UserDataProvider);
    try {
      badge = BadgesModel(currentUser: userData!);
    } catch (e) {
      developer.log(e.toString());
    }
    return Scaffold(
        body: Container(
      height: 1000,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(background),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  stopwatchsubscrip!.cancel();
                  stopwatch = null;
                  setState(() {
                    min = '0';
                    sec = '00';
                  });
                  jiggle =
                      List.filled(definitions.length, List.filled(3, null));
                  missedCards.clear();
                  wrongCards.clear();
                  randomize(definitions.length);
                  // bool allbadgecheck = false;
                  // Navigator.pop(context);
                  // for (var entry in badgecheck.entries) {
                  //   if (entry.value == true) {
                  //     Navigator.pushNamed(context, '/badges',
                  //         arguments: {"badgeIndex": badgecheck});
                  //     break;
                  //   }
                  // }

                  badgecheck.then((value) {
                    if (value.containsValue(true)) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return BadgePopUp(
                                badgecheck: badgecheck,
                                badge: badge,
                                deck: widget.deck);
                          });
                    } else {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/deck',
                          arguments: {"deck": widget.deck});
                    }
                  });
                  // badgecheck.then((value) {
                  //   if (value != null) {
                  //     showDialog(
                  //         context: context,
                  //         builder: (context) {
                  //           return BadgePopUp(
                  //               badgecheck: badgecheck, badge: badge);
                  //         });
                  //   }
                  //   Navigator.pushNamed(context, '/deck',
                  //       arguments: {"deck": widget.deck});
                  // });
                },
                //   for (int b = 0; b < badgecheck.length - 1; b++) {

                //   //   if (badgecheck[b] == true) {
                //   //     developer.log(badgecheck[b].toString());
                //   //     Navigator.pushReplacementNamed(context, '/badges',
                //   //         arguments: {
                //   //           "badgeIndex": badgecheck.keys.elementAt(b)
                //   //         });
                //   //   }
                //   // }
                //   // Navigator.pop(context);
                // },
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Images/icons/close_button.png")),
                    ),
                    child: const Text(""),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Column(
                children: [
                  Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("Images/icons/stopwatch.png"),
                        fit: BoxFit.cover,
                      ))),
                  Text(
                    "$min:$sec",
                    style: const TextStyle(
                      fontFamily: "PolySans_Median",
                      color: Color(0xff551B1B),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
              child: SizedBox(
                width: 55,
                height: 55,
                child: PopupMenuButton(
                  color: const Color.fromARGB(255, 244, 198, 198),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  icon: SvgPicture.asset("Images/icons/svg/more-fill.svg"),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          missed = true;
                          for (int m = i; m < definitions.length; m++) {
                            missedCards.add(testCardsList[m][1]);
                          }
                          stopwatchsubscrip!.pause();
                          model
                              .addTestResults(wrongCards, missedCards,
                                  timeTaken, seconds, userData!.id)
                              .then(
                                (value) => gotData = true,
                              );
                          badgecheck = badge.testCheck(widget.deck);
                        });
                      },
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [
                          Icon(Icons.exit_to_app_rounded),
                          SizedBox(width: 10),
                          Text("Quit & Submit Test"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {},
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [
                          Icon(Icons.dark_mode_outlined),
                          SizedBox(width: 10),
                          Text("Dark Page Theme"), //todo provider
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                CardWidget.emptyCard(
                  width: 350,
                  height: 512,
                  image: "Images/cards/testpage/1.png",
                  updateParent: () {},
                )
              ],
            ),
            CardWidget.emptyCard(
              width: 350,
              height: 512,
              image: "Images/cards/testpage/2.png",
              updateParent: () {},
            ),
            Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                (i < definitions.length && !missed)
                    ? Stack(
                        children: [
                          for (int j = definitions.length - 1; j >= 0; j--)
                            TweenAnimationBuilder(
                                tween:
                                    Tween<double>(begin: start[j], end: end[j]),
                                duration: animduration,
                                builder: (context, pos, __) {
                                  return Transform(
                                    transform: Matrix4.identity()
                                      ..translate(pos),
                                    child: Container(
                                        width: (MediaQuery.of(context)
                                                    .size
                                                    .height >
                                                652)
                                            ? 350
                                            : 300,
                                        height: (MediaQuery.of(context)
                                                    .size
                                                    .height >
                                                751)
                                            ? 512
                                            : (MediaQuery.of(context)
                                                        .size
                                                        .height >
                                                    652)
                                                ? 512
                                                : 312,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "Images/cards/testpage/0.png"),
                                              fit: BoxFit.fill),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 35.0, horizontal: 20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AutoSizeText(
                                                // 150 chars max
                                                // definitions[0].toString()[0].toUpperCase()+definitions[0].toString().substring(1),
                                                definitions[j].toString(),
                                                maxLines: 6,
                                                overflow: TextOverflow.ellipsis,
                                                minFontSize: 17,
                                                stepGranularity: 1,
                                                style: TextStyle(
                                                  fontFamily: "PolySans_Median",
                                                  color: Color(0xff551B1B),
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Column(
                                                children: [
                                                  for (int k = 0; k < 3; k++)
                                                    Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (isActive[j])
                                                              // ignore: curly_braces_in_flow_control_structures
                                                              setState(() {
                                                                isActive[j] =
                                                                    false;
                                                                if (j + 1 <
                                                                    definitions
                                                                        .length)
                                                                  // ignore: curly_braces_in_flow_control_structures
                                                                  isActive[j +
                                                                      1] = true;
                                                                jiggle = List.filled(
                                                                    definitions
                                                                        .length,
                                                                    List.filled(
                                                                        3,
                                                                        null));
                                                                if (terms[
                                                                        j][randomlist[
                                                                            j]
                                                                        [k]] ==
                                                                    testCardsList[
                                                                        j][1]) {
                                                                  jiggle[j] = [
                                                                    for (int f =
                                                                            0;
                                                                        f < 3;
                                                                        f++)
                                                                      if (f ==
                                                                          k)
                                                                        false
                                                                      else
                                                                        null
                                                                  ];
                                                                } else {
                                                                  jiggle[j] = [
                                                                    for (int f =
                                                                            0;
                                                                        f < 3;
                                                                        f++)
                                                                      if (f ==
                                                                          k)
                                                                        true
                                                                      else
                                                                        null
                                                                  ];
                                                                  wrongCards[
                                                                      testCardsList[
                                                                              j]
                                                                          [
                                                                          1]] = terms[j]
                                                                      [
                                                                      randomlist[
                                                                              j]
                                                                          [k]];
                                                                }
                                                                Timer(
                                                                    Duration(
                                                                        milliseconds:
                                                                            85),
                                                                    () {
                                                                  if (i <
                                                                      definitions
                                                                          .length)
                                                                    end[j] =
                                                                        500;
                                                                  i++;
                                                                });
                                                                if (j ==
                                                                    definitions
                                                                            .length -
                                                                        1) {
                                                                  end[j] = 500;
                                                                  i++;
                                                                  stopwatchsubscrip!
                                                                      .pause();
                                                                  model
                                                                      .addTestResults(
                                                                          wrongCards,
                                                                          missedCards,
                                                                          timeTaken,
                                                                          seconds,
                                                                          userData!
                                                                              .id)
                                                                      .then(
                                                                        (value) =>
                                                                            gotData =
                                                                                true,
                                                                      );
                                                                  badgecheck = badge
                                                                      .testCheck(
                                                                          widget
                                                                              .deck);
                                                                }
                                                              });
                                                          },
                                                          child: ShakeWidget(
                                                            shakeConstant:
                                                                ShakeRotateConstant2(),
                                                            autoPlay: jiggle[j]
                                                                    [k] ??
                                                                false,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    200),
                                                            enableWebMouseHover:
                                                                true,
                                                            child: Container(
                                                                width: 305,
                                                                height: 71,
                                                                decoration: checkBox(
                                                                    (jiggle[j][k] !=
                                                                            null)
                                                                        ? !jiggle[j]
                                                                            [k]!
                                                                        : null),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        AutoSizeText(
                                                                      terms[j][randomlist[j]
                                                                              [
                                                                              k]]
                                                                          .toString(),
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      minFontSize:
                                                                          16,
                                                                      // 37 around 35 chars max
                                                                      stepGranularity:
                                                                          1,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontFamily:
                                                                            "PolySans_Neutral",
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            56,
                                                                            18,
                                                                            18),
                                                                        fontSize:
                                                                            26,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                )),
                                                          ),
                                                        ),
                                                        if (k != 2)
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  );
                                })
                        ],
                      )
                    : Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.height > 652)
                                  ? 350
                                  : 300,
                              height: (MediaQuery.of(context).size.height > 751)
                                  ? 512
                                  : (MediaQuery.of(context).size.height > 652)
                                      ? 512
                                      : 312,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "Images/cards/testpage/0.png"),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Column(
                              // mainAxisAlignment:
                              //     MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 55,
                                    ),
                                    const Text(
                                      "Way to go!",
                                      style: TextStyle(
                                        fontFamily: "PolySans_Median",
                                        fontSize: 48,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff39131C),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 85),
                                      const Text(
                                        "You're done with your test!",
                                        style: TextStyle(
                                            fontFamily: "PolySans_Slim",
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xff1B1B1B),
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 35.0, horizontal: 20.0),
                                    child: Column(
                                      children: [
                                        (gotData)
                                            ? Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  PhysicalShape(
                                                    clipBehavior: Clip.hardEdge,
                                                    color: Colors.transparent,
                                                    clipper: ShapeBorderClipper(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            side: BorderSide(
                                                                width: 2))),
                                                    child: Shimmer(
                                                      color: Color.fromARGB(
                                                          255, 253, 255, 226),
                                                      colorOpacity: 0.5,
                                                      interval:
                                                          Duration(seconds: 5),
                                                      direction:
                                                          ShimmerDirection
                                                              .fromRTLB(),
                                                      child: RawMaterialButton(
                                                          enableFeedback: false,
                                                          splashColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          elevation: 0,
                                                          focusElevation: 0,
                                                          highlightElevation: 0,
                                                          disabledElevation: 0,
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          fillColor:
                                                              Color.fromARGB(
                                                                  230,
                                                                  200,
                                                                  255,
                                                                  209),
                                                          constraints:
                                                              BoxConstraints(
                                                                  maxWidth:
                                                                      305.0,
                                                                  maxHeight:
                                                                      61.0),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                  side:
                                                                      BorderSide(
                                                                    width: 2,
                                                                    color: Color(
                                                                        0xCC6BFFA6),
                                                                  )),
                                                          onPressed: () {},
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  AutoSizeText(
                                                                "View Leaderboard",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                minFontSize: 16,
                                                                stepGranularity:
                                                                    1,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "PolySans_Neutral",
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          36,
                                                                          36,
                                                                          36),
                                                                  fontSize: 22,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (gotData)
                                                        Future((() =>
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/leaderboard',
                                                                arguments: {
                                                                  "deck": widget
                                                                      .deck
                                                                })));
                                                    },
                                                    child: Container(
                                                        width: 305,
                                                        height: 70,
                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "Images/icons/stars.png")),
                                                        )),
                                                  )
                                                ],
                                              )
                                            : Container(),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        RawMaterialButton(
                                            enableFeedback: false,
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            elevation: 0,
                                            focusElevation: 0,
                                            highlightElevation: 0,
                                            disabledElevation: 0,
                                            padding: EdgeInsets.all(0),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            fillColor: Colors.white54,
                                            constraints: BoxConstraints(
                                                maxWidth: 305.0,
                                                maxHeight: 61.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            onPressed: () => {
                                                  Future((() =>
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/testresults',
                                                          arguments: {
                                                            "model": model,
                                                          })))
                                                },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: AutoSizeText(
                                                  "View Test Results",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  minFontSize: 16,
                                                  stepGranularity: 1,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "PolySans_Neutral",
                                                    color: Color.fromARGB(
                                                        255, 36, 36, 36),
                                                    fontSize: 22,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        RawMaterialButton(
                                            enableFeedback: false,
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            elevation: 0,
                                            focusElevation: 0,
                                            highlightElevation: 0,
                                            disabledElevation: 0,
                                            padding: EdgeInsets.all(0),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            fillColor: Colors.white30,
                                            constraints: BoxConstraints(
                                                maxWidth: 305.0,
                                                maxHeight: 61.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            onPressed: () => {
                                                  setState(() {
                                                    stopwatchsubscrip!.cancel();
                                                    stopwatch = null;
                                                    setState(() {
                                                      min = '0';
                                                      sec = '00';
                                                    });
                                                    jiggle = List.filled(
                                                        definitions.length,
                                                        List.filled(3, null));
                                                    Navigator.popAndPushNamed(
                                                        context, '/test',
                                                        result: false,
                                                        arguments: {
                                                          "deck": widget.deck
                                                        });
                                                  })
                                                },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: AutoSizeText(
                                                  "Try Again",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  minFontSize: 16,
                                                  stepGranularity: 1,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "PolySans_Neutral",
                                                    color: Color.fromARGB(
                                                        255, 36, 36, 36),
                                                    fontSize: 22,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ],
            )
          ],
        )
      ]),
    ));
  }
}
