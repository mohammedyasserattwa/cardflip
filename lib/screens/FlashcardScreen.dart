import 'dart:async';

import 'package:cardflip/data/Repositories/flashcard_state.dart';
import "package:flutter/material.dart";
import "../models/flashcardModel.dart";
import '../widgets/navibar.dart';
import "../widgets/card_widget.dart";
import 'package:cardflip/data/card.dart' as CardHandler;
import 'package:flutter_svg/flutter_svg.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

class Flashcard extends ConsumerStatefulWidget {
  String id;
  Flashcard({key, this.id = "1"});

  @override
  ConsumerState<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends ConsumerState<Flashcard>
    with SingleTickerProviderStateMixin {
  late FlashcardModel model;
  // dynamic size = 0;
  int _currentCard = 0;
  double _beginAnimation = 0;
  double _endAnimation = 0;
  bool _viewFav = false;
  int _progress = 0;
  late List<CardHandler.Card> currentList;

  @override
  void initState() {
    super.initState();
    model = FlashcardModel(id: widget.id);
    // model.pushForward(0);
    // print(widget.id);
    currentList = model.getCards;
    _currentCard = model.queue;
  }

  void _pop() async {
    setState(() {
      if (_currentCard > 0) {
        _beginAnimation = MediaQuery.of(context).size.width / 2;
        _endAnimation = MediaQuery.of(context).size.width * 2;
      }
    });
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
    final flashcardState = ref.watch(FlashcardStateProvider);
    model.pushForward(flashcardState);
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
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: PopupMenuButton(
                          color: const Color(0xffA0F2FA),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          icon: SvgPicture.asset(
                              "Images/icons/svg/more-fill.svg"),
                          onSelected: (value) {
                            String result = value.toString();
                            if (result.contains(" ")) {}
                          },
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
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
                              },
                              child: const Text("View Favourites Only"),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  _currentCard = _currentCard - (_progress);
                                });
                              },
                              child: const Text("View Unseen Flashcards"),
                            ),
                            PopupMenuItem(
                              enabled: _viewFav,
                              onTap: () {
                                setState(() {
                                  currentList = model.getCards;
                                  _currentCard = currentList.length;
                                  _viewFav = false;
                                });
                              },
                              child: Text("View All Flashcards"),
                            ),
                            PopupMenuItem(
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
                                  },
                                );
                              },
                              child: const Text("Change Color"),
                            )
                          ],
                        ),
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
                          startOver: () {
                            setState(() {
                              currentList = model.getCards;
                              _currentCard = model.getCards.length;
                              _beginAnimation =
                                  MediaQuery.of(context).size.width * 2;
                              _endAnimation = 0;
                            });
                          },
                          updateParent: () {},
                          image: model.getImages[2]),
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
