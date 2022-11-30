import 'package:flutter/material.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';

import '../data/card_generator.dart';
import '../widgets/navibar.dart';
import '../widgets/deck.dart';
import 'FlashcardScreen.dart';

class Leaderboard extends StatelessWidget {
  final CardGenerator cardgenerator = CardGenerator();

  Leaderboard({key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),
      body: Container(
        height: 1000,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Images/backgrounds/TestPage.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Container(
                  height: 596,
                  width: 343,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("Images/banners/leaderboardpage/Card.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("Images/avatars/3.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        // children: [
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.fromLTRB(25, 5, 0, 7),
        //         child: Container(
        //           alignment: Alignment.centerRight,
        //           child: GestureDetector(
        //               onTap: () {},
        //               child: Container(
        //                   decoration: const BoxDecoration(
        //                     image: DecorationImage(
        //                         image: AssetImage("Images/icons/bar.png"),
        //                         fit: BoxFit.cover),
        //                   ),
        //                   width: 136.71,
        //                   height: 55,
        //                   child: const Center(
        //                       child: Text(
        //                     "Study",
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                       fontSize: 32,
        //                       fontFamily: "PolySans_Median",
        //                     ),
        //                   )))),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.fromLTRB(0, 5, 25, 7),
        //         child: Container(
        //           alignment: Alignment.centerRight,
        //           child: GestureDetector(
        //               onTap: () {},
        //               child: Container(
        //                   decoration: const BoxDecoration(
        //                     image: DecorationImage(
        //                         image: AssetImage("Images/icons/bar.png"),
        //                         fit: BoxFit.cover),
        //                   ),
        //                   width: 136.71,
        //                   height: 55,
        //                   child: const Center(
        //                       child: Text(
        //                     "Test",
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                       fontSize: 32,
        //                       fontFamily: "PolySans_Median",
        //                     ),
        //                   )))),
        //         ),
        //       ),
        //     ],
        //   ),
        //   Expanded(
        //     child: NoGlowScroll(
        //       child: ListView(
        //         children: List.generate(
        //             6,
        //             (index) => Padding(
        //                   padding: const EdgeInsets.only(
        //                       bottom: 21.0, right: 21, left: 21),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Deck(
        //                         cardgenerator: cardgenerator,
        //                         width: 163.13,
        //                         height: 158.67,
        //                         path:
        //                             "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
        //                         min: 3,
        //                         onTap: () {
        //                           Navigator.push(
        //                               context,
        //                               MaterialPageRoute(
        //                                   builder: (context) =>
        //                                       const Flashcard()));
        //                         },
        //                       ),
        //                       Deck(
        //                         cardgenerator: cardgenerator,
        //                         width: 163.13,
        //                         height: 158.67,
        //                         path:
        //                             "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
        //                         min: 3,
        //                         onTap: () {
        //                           Navigator.push(
        //                               context,
        //                               MaterialPageRoute(
        //                                   builder: (context) =>
        //                                       const Flashcard()));
        //                         },
        //                       ),
        //                     ],
        //                   ),
        //                 )),
        //       ),
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
