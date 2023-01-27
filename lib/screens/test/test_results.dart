import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/models/test_model.dart';
import "package:flutter/material.dart";
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
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("Images/icons/close_button.png")),
                        ),
                        child: const Text(""),
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
                            const Center(
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
                                    color: const Color(0x29A7A7A7),
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
                                              style: const TextStyle(
                                                color: Color(0xCC000000),
                                                fontFamily: "PolySans_Median",
                                                fontSize: 19.5,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3.0),
                                              child: AutoSizeText(
                                                "Out of $length questions,",
                                                maxLines: 1,
                                                minFontSize: 15,
                                                overflow: TextOverflow.ellipsis,
                                                stepGranularity: 1,
                                                style: const TextStyle(
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
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 15.0),
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
                                            const SizedBox(width: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: CircularPercentIndicator(
                                                radius: 35.0,
                                                lineWidth: 6.0,
                                                animation: true,
                                                percent:
                                                    testresults['percentage'] /
                                                        100.0,
                                                center: Text(
                                                  "${testresults['percentage']}%",
                                                  style: const TextStyle(
                                                    color: Color(0xff6B8C8E),
                                                    fontFamily:
                                                        "PolySans_Median",
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                                progressColor:
                                                    const Color(0xff88BABD),
                                                backgroundColor:
                                                    const Color(0x8CC6C6C6),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: AutoSizeText(
                                                "right in ${testresults['duration']}.",
                                                maxLines: 1,
                                                minFontSize: 15,
                                                overflow: TextOverflow.ellipsis,
                                                stepGranularity: 1,
                                                style: const TextStyle(
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
                                      const SizedBox(height: 25),
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 30.0),
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
                                                  CircularPercentIndicator(
                                                    radius: 20.0,
                                                    lineWidth: 4.5,
                                                    animation: true,
                                                    percent: 1,
                                                    center: AutoSizeText(
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
                                                      style: const TextStyle(
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
                                                        const Color(0xff95BD87),
                                                    backgroundColor:
                                                        const Color(0x8CC6C6C6),
                                                  ),
                                                  const Center(
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
                                                  CircularPercentIndicator(
                                                    radius: 20.0,
                                                    lineWidth: 4.5,
                                                    animation: true,
                                                    percent: 1,
                                                    center: AutoSizeText(
                                                      (testresults['missed']
                                                              .length)
                                                          .toString(),
                                                      maxLines: 1,
                                                      minFontSize: 14,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      stepGranularity: 1,
                                                      style: const TextStyle(
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
                                                        const Color(0xffA5A5A5),
                                                    backgroundColor:
                                                        const Color(0x8CC6C6C6),
                                                  ),
                                                  const Center(
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
                                                  CircularPercentIndicator(
                                                    radius: 20.0,
                                                    lineWidth: 4.5,
                                                    animation: true,
                                                    percent: 1,
                                                    center: AutoSizeText(
                                                      (testresults['wrong']
                                                              .length)
                                                          .toString(),
                                                      maxLines: 1,
                                                      minFontSize: 14,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      stepGranularity: 1,
                                                      style: const TextStyle(
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
                                                        const Color(0xffF4A2A2),
                                                    backgroundColor:
                                                        const Color(0x8CC6C6C6),
                                                  ),
                                                  const Center(
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
                                      ? const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "Images/backgrounds/testresultsheader.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const BoxDecoration(
                                          color: Colors.transparent),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      const Align(
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
                                                        display = [
                                                          ...deckCards
                                                        ];
                                                      }
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
                                                      child: const Center(
                                                          child: Text(
                                                        "All",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff484848),
                                                            fontSize: 20,
                                                            fontFamily:
                                                                "PolySans_Neutral"),
                                                      )))),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (!status["correct"]! &&
                                                          deckCards
                                                                  .map((e) =>
                                                                      e.getTerm)
                                                                  .toSet()
                                                                  .difference(testresults[
                                                                          "wrong"]
                                                                      .keys
                                                                      .toSet()
                                                                      .union(testresults[
                                                                              "missed"]
                                                                          .toSet()))
                                                                  .length ==
                                                              0) {
                                                        status["correct"] =
                                                            false;
                                                        status["false"] = false;
                                                        status["missed"] =
                                                            false;
                                                        status["all"] = true;
                                                        if (display.isNotEmpty)
                                                          display.clear();
                                                        display = [
                                                          ...deckCards
                                                        ];
                                                      }
                                                      if (deckCards
                                                              .map((e) =>
                                                                  e.getTerm)
                                                              .toSet()
                                                              .difference(testresults[
                                                                      "wrong"]
                                                                  .keys
                                                                  .toSet()
                                                                  .union(testresults[
                                                                          "missed"]
                                                                      .toSet()))
                                                              .length ==
                                                          0) {
                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            duration: Duration(
                                                                seconds: 1),
                                                            content: Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Poppins"),
                                                                'You didn\'t have any correct answers.')));
                                                      } else if (!status[
                                                          "correct"]!) {
                                                        status["all"] = false;
                                                        status["correct"] =
                                                            true;
                                                        status["false"] = false;
                                                        status["missed"] =
                                                            false;
                                                        if (display.isNotEmpty)
                                                          display.clear();
                                                        display = [
                                                          ...deckCards
                                                        ];
                                                        for (int x = 0;
                                                            x <
                                                                deckCards
                                                                    .length;
                                                            x++) {
                                                          if (testresults[
                                                                      'wrong']
                                                                  .containsKey(
                                                                      deckCards[
                                                                              x]
                                                                          .getTerm) ||
                                                              testresults[
                                                                      'missed']
                                                                  .contains(
                                                                      deckCards[
                                                                              x]
                                                                          .getTerm)) {
                                                            display.remove(
                                                                deckCards[x]);
                                                          }
                                                        }
                                                        developer
                                                            .log("$status");
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
                                                      child: const Center(
                                                          child: Text(
                                                        "Correct",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff484848),
                                                            fontSize: 20,
                                                            fontFamily:
                                                                "PolySans_Neutral"),
                                                      )))),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (!status["false"]! &&
                                                          testresults["wrong"]
                                                                  .length ==
                                                              0) {
                                                        status["false"] = false;
                                                        status["correct"] =
                                                            false;
                                                        status["missed"] =
                                                            false;
                                                        status["all"] = true;

                                                        if (display.isNotEmpty)
                                                          display.clear();
                                                        display = [
                                                          ...deckCards
                                                        ];
                                                      }
                                                      if (testresults["wrong"]
                                                              .length ==
                                                          0) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                                    behavior:
                                                                        SnackBarBehavior
                                                                            .floating,
                                                                    duration:
                                                                        Duration(
                                                                            seconds:
                                                                                1),
                                                                    content:
                                                                        Text(
                                                                      'You don\'t have any wrong answers!',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins"),
                                                                    )));
                                                      } else {
                                                        status["all"] = false;
                                                        status["false"] = true;
                                                        status["correct"] =
                                                            false;
                                                        status["missed"] =
                                                            false;
                                                        if (display.isNotEmpty)
                                                          display.clear();
                                                        for (int x = 0;
                                                            x <
                                                                deckCards
                                                                    .length;
                                                            x++) {
                                                          if (testresults[
                                                                  "wrong"]
                                                              .containsKey(
                                                                  deckCards[x]
                                                                      .getTerm)) {
                                                            display.add(
                                                                deckCards[x]);
                                                          }
                                                        }
                                                        developer.log(
                                                            display.toString());
                                                      }
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
                                                      child: const Center(
                                                          child: Text(
                                                        "False",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff484848),
                                                            fontSize: 20,
                                                            fontFamily:
                                                                "PolySans_Neutral"),
                                                      )))),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (!status["missed"]! &&
                                                          testresults["missed"]
                                                                  .length ==
                                                              0) {
                                                        status["missed"] =
                                                            false;
                                                        status["false"] = false;
                                                        status["correct"] =
                                                            false;
                                                        status["all"] = true;

                                                        if (display.isNotEmpty)
                                                          display.clear();
                                                        display = [
                                                          ...deckCards
                                                        ];
                                                      }
                                                      if (testresults["missed"]
                                                              .length ==
                                                          0) {
                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            duration: Duration(
                                                                seconds: 1),
                                                            content: Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Poppins"),
                                                                'You didn\'t miss any questions!')));
                                                      } else {
                                                        status["all"] = false;
                                                        status["missed"] = true;
                                                        status["correct"] =
                                                            false;
                                                        status["false"] = false;
                                                        if (display.isNotEmpty)
                                                          display.clear();
                                                        for (int x = 0;
                                                            x <
                                                                deckCards
                                                                    .length;
                                                            x++) {
                                                          if (testresults[
                                                                  "missed"]
                                                              .contains(
                                                                  deckCards[x]
                                                                      .getTerm)) {
                                                            display.add(
                                                                deckCards[x]);
                                                          }
                                                        }
                                                      }
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
                                                      child: const Center(
                                                          child: Text(
                                                        "Missed",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Color(
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
                                          children: const [
                                            Expanded(
                                              child: AutoSizeText(
                                                "Terms",
                                                maxLines: 1,
                                                minFontSize: 16,
                                                wrapWords: false,
                                                overflow: TextOverflow.ellipsis,
                                                stepGranularity: 1,
                                                style: TextStyle(
                                                    color: Color(0xff484848),
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
                                                wrapWords: false,
                                                overflow: TextOverflow.ellipsis,
                                                stepGranularity: 1,
                                                style: TextStyle(
                                                    color: Color(0xff484848),
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
                                                                      .getTerm
                                                                      .toString()
                                                                  : display[i]
                                                                      .getTerm
                                                                      .toString(),
                                                              maxLines: 3,
                                                              minFontSize: 13,
                                                              wrapWords: false,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              stepGranularity:
                                                                  1,
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xff484848),
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      "PolySans_Neutral"),
                                                            ),
                                                          ),
                                                        ),
                                                        (display.isNotEmpty &&
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
                                                                            testresults['wrong'][deckCards[i].getTerm] !=
                                                                                null)
                                                                        ? 'You picked:\n${testresults['wrong'][deckCards[i].getTerm]}'
                                                                        : (status['false']! == true &&
                                                                                display.isNotEmpty)
                                                                            ? 'You picked:\n${testresults['wrong'][display[i].getTerm]}'
                                                                            : "",
                                                                    maxLines: 3,
                                                                    minFontSize:
                                                                        13,
                                                                    wrapWords:
                                                                        false,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    stepGranularity:
                                                                        1,
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xff484848),
                                                                        fontSize:
                                                                            17,
                                                                        fontFamily:
                                                                            "PolySans_Median"),
                                                                  ),
                                                                ),
                                                              )
                                                            : const Text(""),
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
                                                                  .getDefinitions
                                                                  .toString()
                                                              : display[i]
                                                                  .getDefinitions
                                                                  .toString(),
                                                          maxLines: 6,
                                                          minFontSize: 14,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          stepGranularity: 1,
                                                          style: const TextStyle(
                                                              color: Color(
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
                                            const SizedBox(
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
