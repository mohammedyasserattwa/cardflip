import 'package:cardflip/models/leaderboard_model.dart';
import 'package:flutter/material.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'package:cardflip/data/deck.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/data/Repositories/user_state.dart';
import "dart:developer" as developer;

class Leaderboard extends ConsumerWidget {
  Deck deck;
  late Leaderboard model;
  late Map leaderboard = {};

  Leaderboard({super.key, required this.deck});

  Widget userRank(var value, String id) {
    var tempData = value.keys
        .where((element) =>
            value[element]['userInfo']['ID'] == id &&
            value[element]['rank'] != 1 &&
            value[element]['rank'] != 2 &&
            value[element]['rank'] != 3)
        .toList();

    Widget? userCard = null;
    if (tempData.isNotEmpty) {
      userCard = Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        child: Container(
          width: 304,
          height: 71,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0x66ffffff),
              border: Border.all(
                  color: const Color.fromARGB(96, 0, 102, 10), width: 2)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: SvgPicture.asset(
                          "Images/avatars/${value[tempData[0]]['userInfo']['profileIcon']}.svg"),
                    ),
                    Container(
                      width: 26,
                      height: 24,
                      decoration: (value[tempData[0]]['rank'] <= 5)
                          ? BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(((value[tempData[0]]
                                              ['rank'] ==
                                          1)
                                      ? "Images/icons/1strank.png"
                                      : (value[tempData[0]]['rank'] == 2)
                                          ? "Images/icons/2ndrank.png"
                                          : (value[tempData[0]]['rank'] == 3)
                                              ? "Images/icons/3rdrank.png"
                                              : "Images/icons/rank.png")),
                                  fit: BoxFit.contain),
                            )
                          : const BoxDecoration(),
                      child: (value[tempData[0]]['rank'] >= 3)
                          ? Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                AutoSizeText(
                                  value[tempData[0]]['rank'].toString(),
                                  style: TextStyle(
                                    fontFamily: "PolySans_Median",
                                    fontWeight: FontWeight.w500,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 3
                                      ..color = Color(0xFFE89B05),
                                    fontSize: 7.5,
                                  ),
                                ),
                                AutoSizeText(
                                  value[tempData[0]]['rank'].toString(),
                                  style: TextStyle(
                                    fontFamily: "PolySans_Median",
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFFFDD28),
                                    fontSize: 7.5,
                                  ),
                                ),
                              ],
                            )
                          : Text(""),
                      //   ],
                      // ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 3.0,
                ),
                child: SizedBox(
                  width: 190,
                  child: AutoSizeText(
                    value[tempData[0]]['userInfo']['fname'] +
                        ' ' +
                        value[tempData[0]]['userInfo']['lname'],
                    maxLines: 1,
                    minFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    stepGranularity: 1,
                    style: TextStyle(
                      fontFamily: "PolySans_Median",
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(215, 28, 28, 28),
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      value.remove(tempData[0]);
    }

    return Column(
      children: [
        if (userCard != null) userCard,
        SizedBox(
          height: 450,
          child: ListView.builder(
              itemCount: (value.keys.length <= 50) ? value.keys.length : 50,
              itemBuilder: (BuildContext context, int i) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                  child: Container(
                    width: 304,
                    height: 71,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0x66ffffff),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: SvgPicture.asset(
                                    "Images/avatars/${value.values.toList()[i]['userInfo']['profileIcon']}.svg"),
                              ),
                              Container(
                                width: 26,
                                height: 24,
                                decoration: (i <= 5)
                                    ? BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(((value.values
                                                        .toList()[i]['rank'] ==
                                                    1)
                                                ? "Images/icons/1strank.png"
                                                : (value.values.toList()[i]
                                                            ['rank'] ==
                                                        2)
                                                    ? "Images/icons/2ndrank.png"
                                                    : (value.values.toList()[i]
                                                                ['rank'] ==
                                                            3)
                                                        ? "Images/icons/3rdrank.png"
                                                        : "Images/icons/rank.png")),
                                            fit: BoxFit.contain),
                                      )
                                    : const BoxDecoration(),
                                child: (i >= 3)
                                    ? Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          AutoSizeText(
                                            value.values
                                                .toList()[i]['rank']
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: "PolySans_Median",
                                              fontWeight: FontWeight.w500,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 3
                                                ..color = Color(0xFFE89B05),
                                              fontSize: 8,
                                            ),
                                          ),
                                          AutoSizeText(
                                            value.values
                                                .toList()[i]['rank']
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: "PolySans_Median",
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFFFDD28),
                                              fontSize: 8,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(""),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            top: 3.0,
                          ),
                          child: SizedBox(
                            width: 190,
                            child: AutoSizeText(
                              value.values.toList()[i]['userInfo']['fname'] +
                                  ' ' +
                                  value.values.toList()[i]['userInfo']['lname'],
                              maxLines: 1,
                              minFontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              stepGranularity: 1,
                              style: TextStyle(
                                fontFamily: "PolySans_Median",
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(215, 28, 28, 28),
                                fontSize: 23,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Future getData(String id) async {
    LeaderboardModel model = LeaderboardModel(deck: deck);
    leaderboard = await model.leaderboardData();
    return leaderboard;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(UserDataProvider);
    final String background = (MediaQuery.of(context).size.height > 750)
        ? "Images/backgrounds/leaderboardpage.png"
        : (MediaQuery.of(context).size.height > 652)
            ? "Images/backgrounds/leaderboardpage2.png"
            : "Images/backgrounds/leaderboardpage3.png";
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
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
            SizedBox(
              height: (MediaQuery.of(context).size.height > 751)
                  ? 175
                  : (MediaQuery.of(context).size.height > 652)
                      ? 120
                      : 35,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          // SizedBox(
                          //   height: 60,
                          // ),
                          Container(
                            width: (MediaQuery.of(context).size.height > 652)
                                ? 350
                                : 300,
                            height: (MediaQuery.of(context).size.height > 751)
                                ? 530
                                : (MediaQuery.of(context).size.height > 652)
                                    ? 440
                                    : 340,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "Images/cards/leaderboard/2.png")),
                            ),
                            child: const Text(""),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 342,
                            height: 452,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "Images/cards/leaderboard/1.png")),
                            ),
                            child: const Text(""),
                          ),
                        ],
                      ),
                      Container(
                        width: 342,
                        height: 452,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("Images/cards/leaderboard/0.png")),
                        ),
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: NoGlowScroll(
                              child: Scrollbar(
                                child: ListView(
                                  children: [
                                    FutureBuilder(
                                        future: Future.delayed(
                                            Duration(seconds: 1),
                                            () => getData(userData!.id)),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: 140,
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    width: 265,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xff484848),
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "PolySans_Neutral"),
                                                            "Oops! It looks like we hit a snag while loading the leaderboard."),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Text(
                                                            "Don't worry, our team is working on it. In the meantime, why not take a break and come back later?",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        82,
                                                                        82,
                                                                        82),
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    "PolySans_Neutral"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                          if (snapshot.hasData) {
                                            if (snapshot.data.isEmpty) {
                                              return Column(
                                                children: [
                                                  SizedBox(
                                                    height: 170,
                                                  ),
                                                  Center(
                                                    child: SizedBox(
                                                      width: 250,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xff484848),
                                                                  fontSize: 20,
                                                                  fontFamily:
                                                                      "PolySans_Neutral"),
                                                              "The leaderboard is currently empty."),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              "Be the first to claim your spot!",
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          82,
                                                                          82,
                                                                          82),
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      "PolySans_Neutral"),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              leaderboard = snapshot.data!;
                                            }
                                            return userRank(
                                                leaderboard, userData!.id);
                                          } else
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: 200,
                                                ),
                                                CircularProgressIndicator(
                                                  color: Color.fromARGB(
                                                      255, 37, 124, 43),
                                                  semanticsValue: 'Loading',
                                                ),
                                              ],
                                            );
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
