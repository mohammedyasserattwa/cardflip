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
  bool _viewFav = false;
  bool _viewNew = false;
  int _progress = 0;
  late List<CardHandler.Card> currentList;

  @override
  void initState() {
    currentList = model.getCards;
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
    // if (_currentCard == 0) {
    //   print("5alas");
    // }
  }

  void _push() {
    setState(() {
      if (_currentCard < currentList.length) {
        _endAnimation = 0;
        _beginAnimation = MediaQuery.of(context).size.width * 2;
        _currentCard++;
      }
    });
  }

  String countFavourites() {
    int counter = 0;
    for (int i = 0; i < currentList.length; i++) {
      if (currentList[i].isFavourite) {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                image: AssetImage(
                                    "Images/icons/close_button.png")),
                          ),
                        ),
                      ),
                      Container(
                        // child: Text(countFavourites()),
                        child: PopupMenuButton(
                          color: Color(0xffA0F2FA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          icon: SvgPicture.asset(
                              "Images/icons/svg/more-fill.svg"),
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
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                                child: Text("View Favourites Only"),
                                enabled: !_viewFav,
                                onTap: () {
                                  if (int.parse(countFavourites()) > 0) {
                                    // print(model.favourites[0].isFavourite);
                                    setState(() {
                                      currentList = model.favourites;
                                      _currentCard = currentList.length;
                                      _viewFav = true;
                                    });
                                  }
                                }),
                            PopupMenuItem(
                              child: Text("View Unseen Flashcards"),
                              onTap: () {
                                setState(() {
                                  _currentCard = _currentCard - (_progress);
                                });
                              },
                            ),
                            PopupMenuItem(
                                child: Text("View All Flashcards"),
                                enabled: _viewFav,
                                onTap: () {
                                  setState(() {
                                    currentList = model.getCards;
                                    _currentCard = currentList.length;
                                    _viewFav = false;
                                  });
                                }),
                            PopupMenuItem(
                              child: Text("Change Color"),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        title: Text('Test'),
                                        content: Container(
                                          child: Text("Change Color"),
                                        ),
                                      );
                                    });
                              },
                            )
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
              Stack(
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
                                star: (currentList[i].isFavourite
                                    ? Icons.star
                                    : Icons.star_border),
                                card: currentList[i],
                                image: model.getImages[2],
                              )
                            : CardWidget(
                                updateParent: () {
                                  setState(() {
                                    _beginAnimation = 0;
                                    _endAnimation = 0;
                                  });
                                },
                                card: currentList[i],
                                star: (currentList[i].isFavourite
                                    ? Icons.star
                                    : Icons.star_border),
                                image: model.getImages[2],
                              )
                      ],
                    )
                ],
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
                              _progress++;
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
      ),
      // bottomNavigationBar: NavBar(),
    );
  }
}
