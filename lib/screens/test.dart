import 'dart:async';
// import 'dart:html';
// import 'dart:io';
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
import 'dart:math';

class Test extends StatefulWidget {
  String id;
  Test({key, required this.id});

  @override
  State<Test> createState() => _TestState(id: id);
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  String id;
  // int counter = 0;
  bool continuetimer = true;
  Stream<int>? stopwatch;
  StreamSubscription<int>? stopwatchsubscrip;
  String min = "0";
  String sec = "00";
  late BoxDecoration status;
  late TestModel model;
  late Map testCards;
  late List definitions;
  late List terms;
  late bool? isCorrect;
  late List<List<bool?>> jiggle = [];
  final animduration = const Duration(milliseconds: 450);
  List<double> start = [];
  List<double> end = [];
  int i = 0;
  late List shuffled;
  // late AnimationController swipecontroller;
  // late Animation swipeanimation;

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
    start = List.filled(definitions.length, 0.0);
    end = List.filled(definitions.length, 0.0);
    stopwatch = stopWatch();
    jiggle = List.filled(definitions.length, List.filled(3, null));
    stopwatchsubscrip = stopwatch!.listen((int tick) {
      setState(() {
        min = ((tick / 60) % 60).floor().toString();
        sec = (tick % 60).floor().toString().padLeft(2, '0');
      });
    });
    // status1 = BoxDecoration(
    //   border: Border.all(
    //     color: Color.fromARGB(71, 36, 0, 0),
    //     width: 2,
    //   ),
    //   borderRadius: BorderRadius.circular(16),
    //   color: Color(0x40fff4f4),
    // );
    // status2 = BoxDecoration(
    //   border: Border.all(
    //     color: Color.fromARGB(71, 36, 0, 0),
    //     width: 2,
    //   ),
    //   borderRadius: BorderRadius.circular(16),
    //   color: Color(0x40fff4f4),
    // );
    // status3 = BoxDecoration(
    //   border: Border.all(
    //     color: Color.fromARGB(71, 36, 0, 0),
    //     width: 2,
    //   ),
    //   borderRadius: BorderRadius.circular(16),
    //   color: Color(0x40fff4f4),
    // );
    status = BoxDecoration(
      border: Border.all(
        color: Color.fromARGB(71, 36, 0, 0),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(16),
      color: Color(0x40fff4f4),
    );
    // swipecontroller = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: 1500));
    // swipeanimation =
    //     Tween<double>(begin: start, end: end).animate(swipecontroller);

    // swipecontroller.forward();
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

  // String getDefinition() {
  //   if (i < definitions.length) {
  //     return definitions[i].toString();
  //   }
  //   return " ";
  // }

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
                        Stack(
                          children: [
                            for (int j = definitions.length - 1; j >= 0; j--)
                              TweenAnimationBuilder(
                                  // AnimatedBuilder(
                                  tween: Tween<double>(
                                      begin: start[j], end: end[j]),
                                  // animation: swipecontroller,
                                  duration: animduration,
                                  builder: (context, pos, __) => Transform(
                                        transform: Matrix4.identity()
                                          ..translate(pos),
                                        child: Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .height >
                                                  652)
                                              ? 350
                                              : 350 - 50,
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
                                                  : 512 - 200,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "Images/cards/testpage/0.png"),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 35.0,
                                                horizontal: 20.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AutoSizeText(
                                                  // 150 chars max
                                                  // definitions[0].toString()[0].toUpperCase()+definitions[0].toString().substring(1),
                                                  // (getData())[0].toString(),
                                                  definitions[j].toString(),
                                                  // definitions[i].toString(),
                                                  maxLines: 6,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  minFontSize: 17,
                                                  stepGranularity: 1,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "PolySans_Median",
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
                                                              setState(() {
                                                                isCorrect =
                                                                    false;
                                                                jiggle = List.filled(
                                                                    definitions
                                                                        .length,
                                                                    List.filled(
                                                                        3,
                                                                        null));
                                                                jiggle[j] = [
                                                                  for (int f =
                                                                          0;
                                                                      f < 3;
                                                                      f++)
                                                                    if (f == k)
                                                                      true
                                                                    else
                                                                      null
                                                                ];
                                                                // status = checkBox(
                                                                //     !jiggle[j]
                                                                //         [k]!);
                                                                // await Future.delayed(
                                                                //     Duration(
                                                                //         milliseconds: 500));
                                                                // swipecontroller.forward(
                                                                //     from: 0.0);

                                                                Timer(
                                                                    Duration(
                                                                        milliseconds:
                                                                            85),
                                                                    () {
                                                                  end[j] = 500;
                                                                  i++;
                                                                });
                                                                // swipeanimation = Tween<
                                                                //             double>(
                                                                //         begin: 0, end: 500)
                                                                //     .animate(
                                                                //         swipecontroller);
                                                                // int z = 0;
                                                                // jiggle = jiggle
                                                                //   ..map((row) => (z++ !=
                                                                //           j)
                                                                //       ? row.map(
                                                                //           (_) =>
                                                                //               null)
                                                                //       : jiggle[
                                                                //               j]
                                                                //           [
                                                                //           k]).toList();
                                                              });
                                                            },
                                                            child: ShakeWidget(
                                                              shakeConstant:
                                                                  ShakeRotateConstant2(),
                                                              autoPlay:
                                                                  jiggle[j]
                                                                          [k] ??
                                                                      false,
                                                              // duration: const Duration(
                                                              //     milliseconds: 30),
                                                              enableWebMouseHover:
                                                                  true,
                                                              child: Container(
                                                                  width: 305,
                                                                  height: 71,
                                                                  decoration: checkBox((jiggle[j]
                                                                              [
                                                                              k] !=
                                                                          null)
                                                                      ? !jiggle[
                                                                          j][k]!
                                                                      : null),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            8.0),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          AutoSizeText(
                                                                        terms[j][k]
                                                                            .toString(),
                                                                        // j.toString() +
                                                                        //     ' ' +
                                                                        //     k.toString() +
                                                                        //     ' ' +
                                                                        //     jiggle[j][k].toString(),
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
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
                                                                            TextAlign.center,
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
                                          ),
                                        ),
                                      )),
                          ],
                        ),
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
