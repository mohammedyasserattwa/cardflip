import 'dart:async';

import "package:flutter/material.dart";
import "../models/flashcardModel.dart";
import '../widgets/navibar.dart';
import "../widgets/card_widget.dart";
import 'package:cardflip/data/card.dart' as CardHandler;
import 'package:flutter_svg/flutter_svg.dart';

class Flashcard extends StatefulWidget {
  Flashcard({key});

  @override
  State<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard>
    with SingleTickerProviderStateMixin {
  final model = FlashcardModel();
  // dynamic size = 0;
  int _currentCard = 0;
  double _beginAnimation = 0;
  double _endAnimation = 0;

  @override
  void initState() {
    _currentCard = model.queue;
  }

  void _pop() async {
    setState(() {
      if (_currentCard > 0) {
        _beginAnimation = MediaQuery.of(context).size.width / 2;
        _endAnimation = MediaQuery.of(context).size.width * 2;
        // _currentCard--;
      }
    });
    // if (_currentCard > 0) {
    //   _currentCard =
    //       await Future.delayed(const Duration(milliseconds: 250), () {
    //     return _currentCard - 1;
    //   });
    // }
    if (_currentCard == 0) {
      print("5alas");
    }
  }

  void _push() {
    setState(() {
      if (_currentCard < model.queue) {
        _endAnimation = 0;
        _beginAnimation = MediaQuery.of(context).size.width * 2;
        _currentCard++;
      }
    });
  }

  String countFavourites() {
    int counter = 0;
    for (int i = 0; i < model.queue; i++) {
      if (model.getCards[i].isFavourite) {
        counter++;
      }
    }
    return '$counter';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Images/backgrounds/FlashcardBackground.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 30, bottom: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
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
                    Container(
                      // child: Text(countFavourites()),
                      child: PopupMenuButton(
                        color: Color(0xffA0F2FA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        icon:
                            SvgPicture.asset("Images/icons/svg/more-fill.svg"),
                        onSelected: (value) {
                          String result = value.toString();
                          String operation = result;
                          String color = "";
                          if (result.indexOf(" ") != -1) {
                            operation = result.substring(result.indexOf(" "));
                            color = result.substring(
                                result.indexOf(" ") + 1, result.length);
                          }
                        },
                        itemBuilder: (BuildContext context) => const [
                          PopupMenuItem(child: Text("View Favourites Only"))
                        ],
                      ),
                      width: 50,
                      height: 50,
                      // decoration: const BoxDecoration(
                      //   image: DecorationImage(
                      //       image: AssetImage("Images/icons/more-three.png")),
                      // ),
                    )
                  ]),
            ),
            GestureDetector(
              child: Stack(
                children: [
                  CardWidget.emptyCard(
                    image: model.getImages[0],
                    updateParent: () {},
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      CardWidget.emptyCard(
                          updateParent: () {}, image: model.getImages[1]),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      CardWidget.celebrationCard(
                          updateParent: () {}, image: model.getImages[2]),
                    ],
                  ),
                  for (int i = 0; i < _currentCard; i++)
                    Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        (i == _currentCard - 1)
                            ? CardWidget(
                                updateParent: () {
                                  setState(() {
                                    _beginAnimation = 0;
                                    _endAnimation = 0;
                                  });
                                },
                                begin: _beginAnimation,
                                end: _endAnimation,
                                card: model.getCards[i],
                                image: model.getImages[2],
                              )
                            : CardWidget(
                                updateParent: () {
                                  setState(() {
                                    _beginAnimation = 0;
                                    _endAnimation = 0;
                                  });
                                },
                                card: model.getCards[i],
                                image: model.getImages[2],
                              )
                      ],
                    )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _push();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 50,
                        color: Color(0xff1B4F55),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        _pop();
                        // if (_currentCard > 0) {
                        //   _currentCard--;
                        // }
                        if (_currentCard > 0) {
                          _currentCard = await Future.delayed(
                              const Duration(milliseconds: 250), () {
                            return _currentCard - 1;
                          });
                        }
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 50,
                        color: Color(0xff1B4F55),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: NavBar(),
    );
  }
}
