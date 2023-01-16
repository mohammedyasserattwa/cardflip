import 'dart:ui';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/models/testModel.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'dart:developer' as developer;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sticky_headers/sticky_headers.dart';

class TestResults extends StatefulWidget {
  TestModel model;
  TestResults({
    super.key,
    required this.model,
  });

  @override
  State<TestResults> createState() => _TestResultsState(model: model);
}

class _TestResultsState extends State<TestResults> {
  late TestModel model;
  bool isStuck = false;
  var length = 0;
  Map testresults = {};
  var key;
  var deckCards;
  var display;
  Map<String, bool> status = {
    "all": true,
    "correct": false,
    "false": false,
    "missed": false
  };

  String getMessage() {
    if (0 <= testresults['percentage'] && testresults['percentage'] < 50) {
      return "Tough luck!";
    } else if (50 <= testresults['percentage'] &&
        testresults['percentage'] < 70) {
      return "Almost there!";
    } else if (70 <= testresults['percentage'] &&
        testresults['percentage'] < 90) {
      return "Well done!";
    } else {
      return "Sensational!";
    }
  }

  _TestResultsState({required this.model});

  @override
  void initState() {
    testresults = model.gettestResults;
    deckCards = model.getdeckCards;
    display = [...deckCards];
    length = deckCards.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: 1000,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Images/backgrounds/deckbackground.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
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
              ]),
              Expanded(
                child: NoGlowScroll(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Center(
                              child: Text("Test Results",
                                  style: TextStyle(
                                    color: Color(0xCC000000),
                                    fontFamily: "PolySans_Median",
                                    fontSize: 42,
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 25.0),
                              child: Container(
                                  width: 340,
                                  height: 275,
                                  decoration: BoxDecoration(
                                    color: Color(0x29A7A7A7),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25.0, 20, 15, 15),
                                        child: Row(
                                          children: [
                                            AutoSizeText(
                                              getMessage(),
                                              maxLines: 1,
                                              minFontSize: 16,
                                              overflow: TextOverflow.ellipsis,
                                              stepGranularity: 1,
                                              style: TextStyle(
                                                color: Color(0xCC000000),
                                                fontFamily: "PolySans_Median",
                                                fontSize: 19.5,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3.0),
                                              child: AutoSizeText(
                                                "Out of ${length} questions,",
                                                maxLines: 1,
                                                minFontSize: 15,
                                                overflow: TextOverflow.ellipsis,
                                                stepGranularity: 1,
                                                style: TextStyle(
                                                  color: Color(0xCC000000),
                                                  fontFamily:
                                                      "PolySans_Neutral",
                                                  fontSize: 18,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 32.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15.0),
                                              child: AutoSizeText(
                                                "you got",
                                                maxLines: 1,
                                                minFontSize: 15,
                                                overflow: TextOverflow.ellipsis,
                                                stepGranularity: 1,
                                                style: TextStyle(
                                                  color: Color(0xCC000000),
                                                  fontFamily:
                                                      "PolySans_Neutral",
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child:
                                                  new CircularPercentIndicator(
                                                radius: 35.0,
                                                lineWidth: 6.0,
                                                animation: true,
                                                percent:
                                                    testresults['percentage'] /
                                                        100.0,
                                                center: new Text(
                                                  testresults['percentage']
                                                          .toString() +
                                                      "%",
                                                  style: TextStyle(
                                                    color: Color(0xff6B8C8E),
                                                    fontFamily:
                                                        "PolySans_Median",
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                                progressColor:
                                                    Color(0xff88BABD),
                                                backgroundColor:
                                                    Color(0x8CC6C6C6),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: AutoSizeText(
                                                "right in ${testresults['duration']}.",
                                                maxLines: 1,
                                                minFontSize: 15,
                                                overflow: TextOverflow.ellipsis,
                                                stepGranularity: 1,
                                                style: TextStyle(
                                                  color: Color(0xCC000000),
                                                  fontFamily:
                                                      "PolySans_Neutral",
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 25),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30.0),
                                          child: Text("Test Analysis",
                                              style: TextStyle(
                                                color: Color(0xCC000000),
                                                fontFamily: "PolySans_Median",
                                                fontSize: 16,
                                              )),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                            top: 15,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  new CircularPercentIndicator(
                                                    radius: 20.0,
                                                    lineWidth: 4.5,
                                                    animation: true,
                                                    percent: 1,
                                                    center: new AutoSizeText(
                                                      ((length -
                                                              ((testresults[
                                                                          'wrong']
                                                                      .length) +
                                                                  (testresults[
                                                                          'missed']
                                                                      .length)))
                                                          .toString()),
                                                      maxLines: 1,
                                                      minFontSize: 14,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      stepGranularity: 1,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff748E6B),
                                                        fontFamily:
                                                            "PolySans_Median",
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    circularStrokeCap:
                                                        CircularStrokeCap.round,
                                                    progressColor:
                                                        Color(0xff95BD87),
                                                    backgroundColor:
                                                        Color(0x8CC6C6C6),
                                                  ),
                                                  Center(
                                                    child: Text("correct",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xCC121212),
                                                          fontFamily:
                                                              "PolySans_Neutral",
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  new CircularPercentIndicator(
                                                    radius: 20.0,
                                                    lineWidth: 4.5,
                                                    animation: true,
                                                    percent: 1,
                                                    center: new AutoSizeText(
                                                      (testresults['missed']
                                                              .length)
                                                          .toString(),
                                                      maxLines: 1,
                                                      minFontSize: 14,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      stepGranularity: 1,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff636363),
                                                        fontFamily:
                                                            "PolySans_Median",
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    circularStrokeCap:
                                                        CircularStrokeCap.round,
                                                    progressColor:
                                                        Color(0xffA5A5A5),
                                                    backgroundColor:
                                                        Color(0x8CC6C6C6),
                                                  ),
                                                  Center(
                                                    child: Text("missed",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xCC121212),
                                                          fontFamily:
                                                              "PolySans_Neutral",
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  new CircularPercentIndicator(
                                                    radius: 20.0,
                                                    lineWidth: 4.5,
                                                    animation: true,
                                                    percent: 1,
                                                    center: new AutoSizeText(
                                                      (testresults['wrong']
                                                              .length)
                                                          .toString(),
                                                      maxLines: 1,
                                                      minFontSize: 14,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      stepGranularity: 1,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xffA16060),
                                                        fontFamily:
                                                            "PolySans_Median",
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    circularStrokeCap:
                                                        CircularStrokeCap.round,
                                                    progressColor:
                                                        Color(0xffF4A2A2),
                                                    backgroundColor:
                                                        Color(0x8CC6C6C6),
                                                  ),
                                                  Center(
                                                    child: Text("false",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xCC121212),
                                                          fontFamily:
                                                              "PolySans_Neutral",
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ))
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: NoGlowScroll(
                              child: StickyHeader(
                            callback: (stuckAmount) => {
                              if (stuckAmount <= 0)
                                {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) => setState(() {
                                            isStuck = true;
                                          }))
                                }
                              else
                                {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) => setState(() {
                                            isStuck = false;
                                          }))
                                }
                            },
                            header: Stack(
                              children: [
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: (isStuck)
                                      ? BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "Images/backgrounds/testresultsheader.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : BoxDecoration(
                                          color: Colors.transparent),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text("Test Review",
                                              style: TextStyle(
                                                color: Color(0xCC000000),
                                                fontFamily: "PolySans_Median",
                                                fontSize: 24,
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 15),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (!status["all"]!) {
                                                        status["all"] = true;
                                                        status["correct"] =
                                                            false;
                                                        status["false"] = false;
                                                        status["missed"] =
                                                            false;
                                                      }
                                                      display = [...deckCards];
                                                      developer.log("all " +
                                                          display.toString());
                                                    });
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: (status[
                                                                  "all"]!)
                                                              ? const Color
                                                                      .fromARGB(
                                                                  23, 10, 1, 1)
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      width: 48,
                                                      height: 48,
                                                      child: Center(
                                                          child: Text(
                                                        "All",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff484848),
                                                            fontSize: 20,
                                                            fontFamily:
                                                                // (status["all"]! == true)?
                                                                //     "PolySans_Median":
                                                                "PolySans_Neutral"),
                                                      )))),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (!status["correct"]!) {
                                                        status["all"] = false;
                                                        status["correct"] =
                                                            true;
                                                        status["false"] = false;
                                                        status["missed"] =
                                                            false;
                                                        //  testresults[
                                                        //           'wrong']
                                                        //       .containsKey(
                                                        //           deckCards[i]
                                                        //               .getterm
                                                        display.clear();
                                                        display = [
                                                          ...deckCards
                                                        ];
                                                        for (int x = 0;
                                                            x <
                                                                testresults
                                                                    .length;
                                                            x++) {
                                                          if (testresults[
                                                                      'wrong']
                                                                  .containsKey(
                                                                      deckCards[
                                                                              x]
                                                                          .getterm) ||
                                                              testresults[
                                                                      'missed']
                                                                  .contains(
                                                                      deckCards[
                                                                              x]
                                                                          .getterm))
                                                            display.remove(
                                                                deckCards[x]);
                                                        }
                                                        developer.log(
                                                            "correct " +
                                                                display
                                                                    .toString());
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: (status[
                                                                  "correct"]!)
                                                              ? const Color
                                                                      .fromARGB(
                                                                  23, 10, 1, 1)
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      width: 85,
                                                      height: 48,
                                                      child: Center(
                                                          child: Text(
                                                        "Correct",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff484848),
                                                            fontSize: 20,
                                                            fontFamily:
                                                                "PolySans_Neutral"),
                                                      )))),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (!status["false"]!) {
                                                        status["all"] = false;
                                                        status["correct"] =
                                                            false;
                                                        status["false"] = true;
                                                        status["missed"] =
                                                            false;
                                                      }
                                                      display.clear();
                                                      for (int x = 0;
                                                          x < deckCards.length;
                                                          x++) {
                                                        if (testresults['wrong']
                                                            .containsKey(
                                                                deckCards[x]
                                                                    .getterm))
                                                          display.add(
                                                              deckCards[x]);
                                                      }
                                                      developer.log("false " +
                                                          display.toString());
                                                    });
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: (status["false"]!)
                                                              ? const Color
                                                                      .fromARGB(
                                                                  23, 10, 1, 1)
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      width: 65,
                                                      height: 48,
                                                      child: Center(
                                                          child: Text(
                                                        "False",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff484848),
                                                            fontSize: 20,
                                                            fontFamily:
                                                                "PolySans_Neutral"),
                                                      )))),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (!status["missed"]!) {
                                                        status["all"] = false;
                                                        status["correct"] =
                                                            false;
                                                        status["false"] = false;
                                                        status["missed"] = true;
                                                      }
                                                      display.clear();
                                                      for (int x = 0;
                                                          x <
                                                              testresults
                                                                  .length;
                                                          x++) {
                                                        if (testresults[
                                                                'missed']
                                                            .contains(
                                                                deckCards[x]
                                                                    .getterm))
                                                          display.add(
                                                              deckCards[x]);
                                                      }
                                                      developer.log("missed " +
                                                          display.toString());
                                                    });
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: (status[
                                                                  "missed"]!)
                                                              ? const Color
                                                                      .fromARGB(
                                                                  23, 10, 1, 1)
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      width: 80,
                                                      height: 48,
                                                      child: Center(
                                                          child: Text(
                                                        "Missed",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff484848),
                                                            fontSize: 20,
                                                            fontFamily:
                                                                "PolySans_Neutral"),
                                                      )))),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            60, 0, 0, 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: AutoSizeText(
                                                "Terms",
                                                maxLines: 1,
                                                minFontSize: 16,
                                                wrapWords: true,
                                                overflow: TextOverflow.ellipsis,
                                                stepGranularity: 1,
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xff484848),
                                                    fontSize: 18,
                                                    fontFamily:
                                                        "PolySans_Median"),
                                              ),
                                            ),
                                            Expanded(
                                              child: AutoSizeText(
                                                "Defintions",
                                                maxLines: 1,
                                                minFontSize: 16,
                                                wrapWords: true,
                                                overflow: TextOverflow.ellipsis,
                                                stepGranularity: 1,
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xff484848),
                                                    fontSize: 18,
                                                    fontFamily:
                                                        "PolySans_Median"),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            content: NoGlowScroll(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    // todo
                                    for (int i = 0; i < display.length; i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0x29A7A7A7),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              width: 300,
                                              height: 150,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 20),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: SizedBox(
                                                            width: 100,
                                                            height: 50,
                                                            child: AutoSizeText(
                                                              (status['all'] ==
                                                                      true)
                                                                  ? deckCards[i]
                                                                      .getterm
                                                                      .toString()
                                                                  : display[i]
                                                                      .getterm
                                                                      .toString(),
                                                              maxLines: 2,
                                                              minFontSize: 13,
                                                              wrapWords: true,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              stepGranularity:
                                                                  1,
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xff484848),
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      "PolySans_Neutral"),
                                                            ),
                                                          ),
                                                        ),
                                                        ((key = testresults[
                                                                        'wrong']
                                                                    .containsKey(deckCards[
                                                                            i]
                                                                        .getterm
                                                                        .toString())) &&
                                                                (status["all"] ==
                                                                        true ||
                                                                    status["false"] ==
                                                                        true))
                                                            ? Expanded(
                                                                child: SizedBox(
                                                                  width: 100,
                                                                  height: 50,
                                                                  child:
                                                                      AutoSizeText(
                                                                    (status['all'] ==
                                                                                true &&
                                                                            testresults['wrong'][deckCards[i].getterm] !=
                                                                                null)
                                                                        ? 'You picked:\n' +
                                                                            testresults['wrong'][deckCards[i].getterm]
                                                                                .toString()
                                                                        : (status['false'] == true &&
                                                                                testresults['wrong'][display[i].getterm] != null)
                                                                            ? 'You picked:\n' + testresults['wrong'][display[i].getterm].toString()
                                                                            : "",
                                                                    maxLines: 2,
                                                                    minFontSize:
                                                                        13,
                                                                    wrapWords:
                                                                        true,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    stepGranularity:
                                                                        1,
                                                                    style: TextStyle(
                                                                        color: const Color(
                                                                            0xff484848),
                                                                        fontSize:
                                                                            17,
                                                                        fontFamily:
                                                                            "PolySans_Median"),
                                                                  ),
                                                                ),
                                                              )
                                                            : Text(""),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 0.0),
                                                      child: SizedBox(
                                                        width: 150,
                                                        height: 200,
                                                        child: AutoSizeText(
                                                          (status['all'] ==
                                                                  true)
                                                              ? deckCards[i]
                                                                  .getdefinition
                                                                  .toString()
                                                              : display[i]
                                                                  .getdefinition
                                                                  .toString(),
                                                          // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ultrices nisl erat, non tempus mi pulvinar sit amet. Mauris cursus est molestie fringilla pellentesque. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aliquam a sem erat. Integer eget massa varius, mattis purus a, dapibus neque. Nunc lacinia massa feugiat magna consequat sodales. Sed varius, ipsum a ullamcorper volutpat, leo mi dignissim sapien, ac ultrices urna leo id enim. Duis semper, dolor id elementum vestibulum, turpis sapien pretium ligula, in consectetur nunc ante in tellus. Integer posuere justo quis leo elementum elementum. Mauris faucibus tempor lectus, in efficitur ipsum vulputate sit amet. Integer quam magna, ultricies ut gravida sit amet, fringilla eget lectus. Pellentesque sed malesuada lorem. Curabitur velit ipsum, mattis volutpat justo a, iaculis viverra risus. Nulla quis tortor urna. Nunc dolor nibh, hendrerit ut iaculis et, porttitor at magna. Vestibulum tempor pellentesque urna, dignissim bibendum neque venenatis sed. Nullam tincidunt mauris a ex feugiat, vel placerat turpis tincidunt. Praesent vitae tellus augue. Maecenas non consectetur diam. In dapibus, eros vel consectetur suscipit, ante enim tincidunt justo, non rutrum lacus odio a ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nam dapibus luctus nulla, scelerisque maximus turpis venenatis ut.",
                                                          maxLines: 6,
                                                          minFontSize: 14,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          stepGranularity: 1,
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xff484848),
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  "PolySans_Neutral"),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ])));
  }
}
