import 'dart:async';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../models/testModel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/Test.dart';
import '../data/card_generator.dart';
import '../widgets/card_widget.dart';

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
  late BoxDecoration status;
  late TestModel model;
  late Map testCards;
  late List definitions;
  late List terms;

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

    stopwatch = stopWatch();

    stopwatchsubscrip = stopwatch!.listen((int tick) {
      setState(() {
        // print(tick);
        min = ((tick / 60) % 60).floor().toString();
        sec = (tick % 60).floor().toString().padLeft(2, '0');
      });
    });

    // stream = Stream<int>.periodic(const Duration(seconds: 1), (_) => counter++);
    status = BoxDecoration(
      border: Border.all(
        color: Colors.black,
        width: 1,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
    super.initState();
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
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                              image:
                                  AssetImage("Images/icons/close_button.png")),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 205,
                // ),
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
            Center(
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
                      Container(
                        width: (MediaQuery.of(context).size.height > 652)
                            ? 350
                            : 350 - 50,
                        height: (MediaQuery.of(context).size.height > 751)
                            ? 512
                            : (MediaQuery.of(context).size.height > 652)
                                ? 512
                                : 512 - 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Images/cards/testpage/0.png"),
                              fit: BoxFit.fill),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 35.0, horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                // 150 chars max
                                // definitions[0].toString()[0].toUpperCase()+definitions[0].toString().substring(1),
                                definitions[0].toString(),
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
                                  GestureDetector(
                                    onTap: () {
                                      // check if correct change autoplay value
                                    },
                                    child: ShakeWidget(
                                      shakeConstant: ShakeRotateConstant2(),
                                      autoPlay: false,
                                      enableWebMouseHover: true,
                                      child: Container(
                                          width: 305,
                                          height: 71,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  Color.fromARGB(71, 36, 0, 0),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Color(0x40fff4f4),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AutoSizeText(
                                                terms[0][0].toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                minFontSize: 16,
                                                // 37 around 35 chars max
                                                stepGranularity: 1,
                                                style: TextStyle(
                                                  fontFamily:
                                                      "PolySans_Neutral",
                                                  color: Color(0xff551B1B),
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
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
                                      //
                                    },
                                    child: ShakeWidget(
                                      shakeConstant: ShakeRotateConstant2(),
                                      autoPlay: false,
                                      enableWebMouseHover: true,
                                      child: Container(
                                        width: 305,
                                        height: 71,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(71, 36, 0, 0),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Color(0x40fff4f4),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AutoSizeText(
                                                terms[0][1].toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                minFontSize: 16,
                                                // 37 around 35 chars max
                                                stepGranularity: 1,
                                                style: TextStyle(
                                                  fontFamily:
                                                      "PolySans_Neutral",
                                                  color: Color(0xff551B1B),
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
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
                                      //
                                    },
                                    child: ShakeWidget(
                                      shakeConstant: ShakeRotateConstant2(),
                                      autoPlay: false,
                                      enableWebMouseHover: true,
                                      child: GestureDetector(
                                        child: Container(
                                            width: 305,
                                            height: 71,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color.fromARGB(
                                                    71, 36, 0, 0),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: Color(0x40fff4f4),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: AutoSizeText(
                                                  terms[0][2].toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  minFontSize: 16,
                                                  // 37 around 35 chars max
                                                  stepGranularity: 1,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "PolySans_Neutral",
                                                    color: Color(0xff551B1B),
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
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
                    ],
                  ),
                ],
              ),
            ),
          ]),
    ));
  }
}
