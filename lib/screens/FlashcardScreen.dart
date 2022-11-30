import 'dart:async';

import "package:flutter/material.dart";
import "../models/flashcardModel.dart";
import '../widgets/navibar.dart';
import "../widgets/card_widget.dart";

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
      _beginAnimation = MediaQuery.of(context).size.width / 2;
      _endAnimation = MediaQuery.of(context).size.width * 2;
    });
    if (_currentCard > 0) {
      _currentCard =
          await Future.delayed(const Duration(milliseconds: 250), () {
        return _currentCard - 1;
      });
    }
    if (_currentCard == 0) {
      print("5alas");
    }
  }

  void _push() {
    if (_currentCard < model.queue) {
      _currentCard++;
    }
    setState(() {
      _endAnimation = 0;
      _beginAnimation = MediaQuery.of(context).size.width * 2;
    });
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
                      child: Text(""),
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Images/icons/more-three.png")),
                      ),
                    )
                  ]),
            ),
            GestureDetector(
              child: Stack(
                children: [
                  CardWidget.emptyCard(image: model.getImages[0]),
                  Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      CardWidget.emptyCard(image: model.getImages[1]),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      CardWidget.celebrationCard(image: model.getImages[2]),
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
                                begin: _beginAnimation,
                                end: _endAnimation,
                                term: model.getTerms[i],
                                definition: model.getDefinitions[i],
                                image: model.getImages[2],
                              )
                            : CardWidget(
                                term: model.getTerms[i],
                                definition: model.getDefinitions[i],
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
                      onTap: () {
                        _pop();
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
