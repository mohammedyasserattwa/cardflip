import 'dart:async';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/models/testModel.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/card_widget.dart';
import 'dart:developer' as developer;
import 'package:shimmer_animation/shimmer_animation.dart';

class Test extends StatefulWidget {
  String id;
  Test({key, required this.id});

  @override
  State<Test> createState() => _TestState(id: id);
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  String id;
  bool continuetimer = true;
  Stream<int>? stopwatch;
  StreamSubscription<int>? stopwatchsubscrip;
  String min = "0";
  String sec = "00";
  late BoxDecoration status;
  late TestModel model;
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
  List<List<int>> randomlist = [];
  var testCardsList = [];
  late List<bool> isActive = [];
  String background = "Images/backgrounds/testpage.png";
  // String background = "Images/backgrounds/finaltest.png";
  // ugly all red or all pink

// sh then set then use then remove
  Stream<int> stopWatch() {
    StreamController<int>? controller;
    Timer? timer;
    Duration duration = Duration(seconds: 1);
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

    controller = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );
    return controller.stream;
  }

  @override
  void initState() {
    model = TestModel(id: id);
    testCards = model.getTestCards;
    // testCards..toList();
    testCards.forEach((d, t) => testCardsList.add([d, t[0], t[1], t[2]]));
// print(list);
    testCardsList.shuffle();

    testCardsList.forEach((element) {
      definitions.add(element[0]);
    });

    // terms = testCards.values.toList();
    testCardsList.forEach((element) {
      terms.add([element[1], element[2], element[3]]);
    });

    random.shuffle();
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
        color: Color.fromARGB(71, 36, 0, 0),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(16),
      color: Color(0x40fff4f4),
    );
    super.initState();
  }

  List<List<int>> randomize(int size) {
    List<List<int>> randomlist = [];
    for (int i = 0; i < size; i++) {
      random.shuffle();
      randomlist.add(random);
    }
    return randomlist;
  }

  BoxDecoration checkBox(bool? isCorrect) {
    BoxDecoration status;
    (isCorrect == true)
        ? status = BoxDecoration(
            border: Border.all(
              color: Color(0xB393FF97),
              width: 3,
            ),
            borderRadius: BorderRadius.circular(16),
            color: Color.fromARGB(175, 217, 255, 218),
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

  _TestState({key, required this.id});
  @override
  Future<void> setState(VoidCallback fn) async {
    if (i >= definitions.length)
      background = 'Images/backgrounds/finaltest.png';
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    child: Text(""),
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Images/icons/close_button.png")),
                    ),
                  ),
                ),
              ),
            ),
            if (i < definitions.length)
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Column(
                  children: [
                    Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
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
                  color: Color.fromARGB(255, 244, 198, 198),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  icon: SvgPicture.asset("Images/icons/svg/more-fill.svg"),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      onTap: () {},
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [
                          Icon(Icons.exit_to_app_rounded),
                          SizedBox(width: 10),
                          Text("Quit & Submit Test"), //todo
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
        SizedBox(
          height: 25,
        ),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                SizedBox(
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
                SizedBox(
                  height: 100,
                ),
                (i < definitions.length)
                    ? Stack(
                        children: [
                          for (int j = definitions.length - 1; j >= 0; j--)
                            TweenAnimationBuilder(
                                tween:
                                    Tween<double>(begin: start[j], end: end[j]),
                                duration: animduration,
                                builder: (context, pos, __) {
                                  // random.shuffle();
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
                                                              setState(() {
                                                                isActive[j] =
                                                                    false;
                                                                if (j + 1 <
                                                                    definitions
                                                                        .length)
                                                                  isActive[j +
                                                                      1] = true;
                                                                // developer.log('displayed ' +
                                                                //     terms[j][random[
                                                                //             k]]
                                                                //         .toString() +
                                                                //     '\ntest card list' +
                                                                //     testCardsList[
                                                                //             j][1]);
                                                                jiggle = List.filled(
                                                                    definitions
                                                                        .length,
                                                                    List.filled(
                                                                        3,
                                                                        null));
                                                                if (terms[j][
                                                                        random[
                                                                            k]] ==
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
                                                                          TextStyle(
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
                                                          SizedBox(
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
                                SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
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
                                      SizedBox(width: 85),
                                      const Text(
                                        "You’re done with your test!",
                                        style: TextStyle(
                                            fontFamily: "PolySans_Slim",
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xff1B1B1B),
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 35.0, horizontal: 20.0),
                                    child: Column(
                                      children: [
                                        Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            PhysicalShape(
                                              clipBehavior: Clip.hardEdge,
                                              color: Colors.transparent,
                                              clipper: ShapeBorderClipper(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      side: BorderSide(
                                                          width: 2))),
                                              child: Shimmer(
                                                color: Color.fromARGB(
                                                    255, 253, 255, 226),
                                                colorOpacity: 0.5,
                                                interval: Duration(seconds: 5),
                                                direction:
                                                    ShimmerDirection.fromRTLB(),
                                                child: RawMaterialButton(
                                                    enableFeedback: false,
                                                    splashColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                    focusElevation: 0,
                                                    highlightElevation: 0,
                                                    disabledElevation: 0,
                                                    padding: EdgeInsets.all(0),
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    fillColor: Color.fromARGB(
                                                        230, 200, 255, 209),
                                                    constraints: BoxConstraints(
                                                        maxWidth: 305.0,
                                                        maxHeight: 61.0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                            side: BorderSide(
                                                              width: 2,
                                                              color: Color(
                                                                  0xCC6BFFA6),
                                                            )),
                                                    onPressed: () => {},
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: AutoSizeText(
                                                          "View Leaderboard",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          minFontSize: 16,
                                                          stepGranularity: 1,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "PolySans_Neutral",
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    36,
                                                                    36,
                                                                    36),
                                                            fontSize: 22,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Future((() =>
                                                    Navigator.pushNamed(
                                                        context, '/leaderboard',
                                                        arguments: {
                                                          "deckID": widget.id,
                                                        })));
                                              },
                                              child: Container(
                                                  width: 305,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "Images/icons/stars.png")),
                                                  )),
                                            )
                                          ],
                                        ),
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

                                                    // Navigator
                                                    //     .pushReplacementNamed(
                                                    //         context, '/test',
                                                    //         arguments: {
                                                    //       "deckID": widget.id,
                                                    //     });
                                                    Navigator.popAndPushNamed(
                                                        context, '/test',
                                                        arguments: {
                                                          "deckID": widget.id,
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
