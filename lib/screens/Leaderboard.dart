import 'package:cardflip/models/leaderboardModel.dart';
import 'package:flutter/material.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import '../data/card_generator.dart';
import '../widgets/card_widget.dart';
import '../widgets/navibar.dart';
import '../widgets/deck.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:auto_size_text/auto_size_text.dart';

class Leaderboard extends StatelessWidget {
  String id;
  Leaderboard({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    LeaderboardModel model = new LeaderboardModel(id: id);
    return Scaffold(
      body: Container(
        height: 1000,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Images/backgrounds/leaderboardpage.png"),
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
            SizedBox(
              height: 175,
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
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            width: 342,
                            height: 452,
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
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // TODO
                                    // if ()
                                    // deck to function in leaderboard model that returns list
                                    for (int i = 0;
                                        i < model.leaderboardList.length &&
                                            i < 250;
                                        i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 20),
                                        child: Container(
                                          width: 304,
                                          height: 71,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Color(0x66ffffff),
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .bottomEnd,
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      child: SvgPicture.asset(
                                                          model
                                                              .leaderboardList[
                                                                  i]
                                                              .profileIcon),
                                                    ),
                                                    Container(
                                                      width: 26,
                                                      height: 24,
                                                      decoration: (i < 5)
                                                          ? BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(((i == 0)
                                                                      ? "Images/icons/1strank.png"
                                                                      : (i == 1)
                                                                          ? "Images/icons/2ndrank.png"
                                                                          : (i == 2)
                                                                              ? "Images/icons/3rdrank.png"
                                                                              : "Images/icons/rank.png")),
                                                                  fit: BoxFit.contain),
                                                            )
                                                          : BoxDecoration(),
                                                      // child: Stack(
                                                      //   children: [
                                                      // Image.network(
                                                      //   ((i == 0)
                                                      //       ? "Images/icons/1strank.png"
                                                      //       : (i == 1)
                                                      //           ? "Images/icons/2ndrank.png"
                                                      //           : (i == 2)
                                                      //               ? "Images/icons/3rdrank.png"
                                                      //               : (i == 3 ||
                                                      //                       i == 4)
                                                      //                   ? "Images/icons/rank.png"
                                                      //                   : ""),
                                                      //   errorBuilder:
                                                      //       (BuildContext
                                                      //               context,
                                                      //           Object
                                                      //               exception,
                                                      //           StackTrace?
                                                      //               stackTrace) {
                                                      //     return Text(
                                                      //         'Your error widget...');
                                                      //   },
                                                      // ),
                                                      child: (i >= 3)
                                                          ? Stack(
                                                              alignment:
                                                                  AlignmentDirectional
                                                                      .center,
                                                              children: [
                                                                AutoSizeText(
                                                                  (i + 1)
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "PolySans_Median",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    foreground:
                                                                        Paint()
                                                                          ..style =
                                                                              PaintingStyle.stroke
                                                                          ..strokeWidth =
                                                                              3
                                                                          ..color =
                                                                              Color(0xFFE89B05),
                                                                    fontSize: 8,
                                                                  ),
                                                                ),
                                                                AutoSizeText(
                                                                  (i + 1)
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "PolySans_Median",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Color(
                                                                        0xFFFFDD28),
                                                                    fontSize: 8,
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
                                                    left: 20.0, top: 3.0),
                                                child: AutoSizeText(
                                                  model.leaderboardList[i]
                                                          .firstname +
                                                      ' ' +
                                                      model.leaderboardList[i]
                                                          .lastname,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "PolySans_Median",
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        215, 28, 28, 28),
                                                    fontSize: 23,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    // todo
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
