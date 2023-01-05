import 'dart:async';
// import 'dart:html';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/models/testModel.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../data/Test.dart';
import '../data/card_generator.dart';
import '../widgets/card_widget.dart';
import 'dart:developer' as developer;

class Test extends StatefulWidget {
  String id;
  Test({key, required this.id});

  @override
  State<Test> createState() => _TestState(id: id);
}

class _TestState extends State<Test> {
  String id;
  // int counter = 0;
  bool continuetimer = true;
  Stream<int>? stopwatch;
  StreamSubscription<int>? stopwatchsubscrip;
  String min = "0";
  String sec = "00";
  late BoxDecoration status1;
  late BoxDecoration status2;
  late BoxDecoration status3;
  late TestModel model;
  late Map testCards;
  late List definitions;
  late List terms;
  late bool? isCorrect;
  late bool jiggle;
  final animduration = const Duration(milliseconds: 450);
  var start = 0.0;
  var end = 0.0;
  int i = 0;
  bool cardLimit = true;
  late List shuffled;

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

    // void startTimer() {
    //   timer = Timer.periodic(duration, (_) {
    //     controller!.add(++counter);
    //     if (!continuetimer) {
    //       stopTimer();
    //     }
    //   });
    // }
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
    definitions = testCards.keys.toList();
    terms = testCards.values.toList();
    shuffled = testCards.values.toList();
    shuffled.shuffle();

    stopwatch = stopWatch();
    jiggle = false;
    stopwatchsubscrip = stopwatch!.listen((int tick) {
      setState(() {
        min = ((tick / 60) % 60).floor().toString();
        sec = (tick % 60).floor().toString().padLeft(2, '0');
      });
    });
    status1 = BoxDecoration(
      border: Border.all(
        color: Color.fromARGB(71, 36, 0, 0),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(16),
      color: Color(0x40fff4f4),
    );
    status2 = BoxDecoration(
      border: Border.all(
        color: Color.fromARGB(71, 36, 0, 0),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(16),
      color: Color(0x40fff4f4),
    );
    status3 = BoxDecoration(
      border: Border.all(
        color: Color.fromARGB(71, 36, 0, 0),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(16),
      color: Color(0x40fff4f4),
    );

    // stream = Stream<int>.periodic(const Duration(seconds: 1), (_) => counter++);

    super.initState();
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

  // List getData() {
  //   for (; z < definitions.length - 1;) {
  //     // developer.log(definitions[z].toString());
  //     data.add(definitions[z]);

  //     // developer.log(data.toString());
  //     // for (; j < terms.length * 3;) {
  //     //   data.add(terms[i][j].toString());
  //     // }
  //   }
  //   // print(data.toString());
  //   if (data.isNotEmpty) {
  //     return data;
  //     // print(data);
  //     // developer.log(data.toString());
  //   } else {
  //     return [" "];
  //     // developer.log("data is empty");
  //   }
  // }

  String getDefinition() {
    for (; i < definitions.length;) {
      return definitions[i].toString();
    }
    return " ";
  }

  _TestState({key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 1000,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("Images/backgrounds/testpage.png"),
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
                  jiggle = false;
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
            if (cardLimit)
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
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  icon: SvgPicture.asset("Images/icons/svg/more-fill.svg"),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: Text(""),
                      // child: GestureDetector(
                      //   onTap: () {
                      //     Navigator.pushNamed(context, "/settings");
                      //   },
                      //   child: Row(
                      //     children: [
                      //       SvgPicture.asset(
                      //           "Images/icons/svg/gear-fill.svg"),
                      //       const SizedBox(
                      //         width: 10,
                      //       ),
                      //       const Text("Settings"),
                      //     ],
                      //   ),
                      // ),
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
        (i < definitions.length)
            ? Center(
                child: Stack(
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
                        ),
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
                        // (i < definitions.length)
                        TweenAnimationBuilder(
                            tween: Tween<double>(begin: start, end: end),
                            duration: animduration,
                            builder: (context, double pos, __) => Transform(
                                  transform: Matrix4.identity()..translate(pos),
                                  child: Container(
                                    width: (MediaQuery.of(context).size.height >
                                            652)
                                        ? 350
                                        : 350 - 50,
                                    height: (MediaQuery.of(context)
                                                .size
                                                .height >
                                            751)
                                        ? 512
                                        : (MediaQuery.of(context).size.height >
                                                652)
                                            ? 512
                                            : 512 - 200,
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
                                            // (getData())[0].toString(),
                                            getDefinition(),
                                            // definitions[i].toString(),
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
                                          // for (int j = 0; j < terms.length * 3;)
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isCorrect = false;
                                                    status1 = checkBox(false);
                                                    jiggle = true;
                                                    // await Future.delayed(
                                                    //     Duration(
                                                    //         milliseconds: 500));
                                                    Timer(
                                                        Duration(
                                                            milliseconds: 75),
                                                        () {
                                                      jiggle = false;
                                                    });
                                                    Timer(
                                                        Duration(
                                                            milliseconds: 1000),
                                                        () {
                                                      end = 1000;
                                                    });
                                                    i++;
                                                    if (i <
                                                        definitions.length) {
                                                      cardLimit = true;
                                                    } else {
                                                      cardLimit = false;
                                                    }
                                                  });
                                                },
                                                child: ShakeWidget(
                                                  shakeConstant:
                                                      ShakeRotateConstant2(),
                                                  autoPlay: jiggle,
                                                  duration: const Duration(
                                                      milliseconds: 30),
                                                  enableWebMouseHover: true,
                                                  child: Container(
                                                      width: 305,
                                                      height: 71,
                                                      decoration: status1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: AutoSizeText(
                                                            // terms[0][0].toString(),
                                                            terms[i][0]
                                                                .toString(),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            minFontSize: 16,
                                                            // 37 around 35 chars max
                                                            stepGranularity: 1,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "PolySans_Neutral",
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      56,
                                                                      18,
                                                                      18),
                                                              fontSize: 26,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    // isCorrect = false;
                                                    status1 = checkBox(true);
                                                    jiggle = true;
                                                    end = 1000;
                                                    i++;
                                                    if (i <
                                                        definitions.length) {
                                                      cardLimit = true;
                                                    } else {
                                                      cardLimit = false;
                                                    }
                                                  });
                                                },
                                                child: ShakeWidget(
                                                  shakeConstant:
                                                      ShakeRotateConstant2(),
                                                  autoPlay: false,
                                                  enableWebMouseHover: true,
                                                  child: Container(
                                                    width: 305,
                                                    height: 71,
                                                    decoration: status2,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: AutoSizeText(
                                                            terms[i][1]
                                                                .toString(),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            minFontSize: 16,
                                                            // 37 around 35 chars max
                                                            stepGranularity: 1,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "PolySans_Neutral",
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      56,
                                                                      18,
                                                                      18),
                                                              fontSize: 26,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    // isCorrect = false;
                                                    status1 = checkBox(null);
                                                    jiggle = true;
                                                    end = 1000;
                                                    i++;
                                                    if (i <
                                                        definitions.length) {
                                                      cardLimit = true;
                                                    } else {
                                                      cardLimit = false;
                                                    }
                                                  });
                                                },
                                                child: ShakeWidget(
                                                  shakeConstant:
                                                      ShakeRotateConstant2(),
                                                  autoPlay: false,
                                                  enableWebMouseHover: true,
                                                  child: GestureDetector(
                                                    child: Container(
                                                        width: 305,
                                                        height: 71,
                                                        decoration: status3,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: AutoSizeText(
                                                              terms[i][2]
                                                                  .toString(),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              minFontSize: 16,
                                                              // 37 around 35 chars max
                                                              stepGranularity:
                                                                  1,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "PolySans_Neutral",
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        56,
                                                                        18,
                                                                        18),
                                                                fontSize: 26,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                      ],
                    ),
                  ],
                ),
              )
            : Text("Done..."),
      ]),
    ));
  }
}
