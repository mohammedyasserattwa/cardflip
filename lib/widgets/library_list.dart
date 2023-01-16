import 'package:cardflip/data/Repositories/user_decks.dart';
import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/data/card_generator.dart';
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/deckModel.dart';
import 'package:cardflip/models/userModel.dart';
import "package:flutter/material.dart";
// import "package:go_router/go_router.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:no_glow_scroll/no_glow_scroll.dart';

import '../data/deck.dart' as deck_data;
import "../widgets/deck.dart" as deck_widget;

// ignore: must_be_immutable

class LibraryList extends StatelessWidget {
  CardGenerator cardgenerator = CardGenerator();
  DeckModel deckModel = DeckModel();
  String state;
  // List<deck_data.Deck> deckList = <deck_data.Deck>[];
  LibraryList({this.state = "all"});
  _responsive(BuildContext context) {
    if (MediaQuery.of(context).size.width < 299) {
      return {"height": 113.67, "width": 118.67, "fontSize": 16};
    } else if (MediaQuery.of(context).size.width < 340) {
      return {"height": 128.67, "width": 133.67, "fontSize": 20};
    } else if (MediaQuery.of(context).size.width < 358) {
      return {"height": 148.67, "width": 153.67, "fontSize": 20};
    } else {
      return {"height": 158.67, "width": 163.67, "fontSize": 20};
    }
  }

  late Widget _state;
  int c2 = 0;
  Future<List<Future<Deck>>> getDecks(
      String state, String userID, List favourites) async {
    List<Future<Deck>> decks = await deckModel.deckByUserID(userID);
    List<Future<Deck>> fav =
        favourites.map((e) async => await deckModel.getdeckByID(e)).toList();
    if (state == "all") {
      decks.addAll(fav);
    }
    if (state == "others") {
      decks = [];
      decks = fav;
    }
    return decks;
  }

  List<deck_data.Deck> _temp = [];
  EdgeInsets kpaddingCards =
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15);
  int counter = 0;
  late Widget rendered;
  @override
  Widget build(BuildContext context) {
    final height = _responsive(context)["height"];
    final width = _responsive(context)["width"];
    if (c2++ == 1) {
      rendered = Expanded(
        child: (_temp.isEmpty)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.not_interested,
                    color: Colors.grey,
                    size: 40,
                  ),
                  Text(
                    "Your library is empty, you can create a new deck or like a deck created by others!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "PolySans_Median",
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  )
                ],
              )
            : NoGlowScroll(
                child: ListView(
                children: [
                  for (int i = 0; i < _temp.length; i += 2)
                    Padding(
                      padding: kpaddingCards,
                      child: Row(
                        mainAxisAlignment: (i + 1 < _temp.length)
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.start,
                        children: [
                          deck_widget.Deck(
                              deck: _temp[i],
                              width: width,
                              height: height,
                              min: 3,
                              onTap: () {
                                Navigator.pushNamed(context, "/deck",
                                    arguments: {
                                      "deck": _temp[i],
                                    });
                              },
                              path:
                                  "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                          if (i + 1 < _temp.length)
                            deck_widget.Deck(
                                deck: _temp[i + 1],
                                width: width,
                                height: height,
                                min: 3,
                                onTap: () {
                                  Navigator.pushNamed(context, "/deck",
                                      arguments: {
                                        "deck": _temp[i + 1],
                                      });
                                },
                                path:
                                    "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                        ],
                      ),
                    ),
                ],
              )),
      );
    }
    return (counter++ == 0)
        ? Consumer(
            builder: (context, ref, __) {
              final user = ref.watch(UserDataProvider);
              final favourites = ref.watch(FavouritesProvider);
              _state = Expanded(
                  child: FutureBuilder(
                      future: getDecks(state, user!.id, favourites),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final decks = snapshot.data!;
                          return (decks.isEmpty)
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.not_interested,
                                      color: Colors.grey,
                                      size: 40,
                                    ),
                                    Text(
                                      "Your library is empty, you can create a new deck or like a deck created by others!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "PolySans_Median",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                )
                              : NoGlowScroll(
                                  child: ListView(
                                  children: [
                                    for (int i = 0; i < decks.length; i += 2)
                                      Padding(
                                        padding: kpaddingCards,
                                        child: Row(
                                          mainAxisAlignment: (i + 1 <
                                                  decks.length)
                                              ? MainAxisAlignment.spaceBetween
                                              : MainAxisAlignment.start,
                                          children: [
                                            FutureBuilder(
                                                future: decks[i],
                                                builder: (context, deckData) {
                                                  if (deckData.hasData) {
                                                    Deck deck = deckData.data!;
                                                    //UGLY: code contains a bug in the Yours page
                                                    if (state == "user")
                                                      print(
                                                          "Current Length: ${_temp.length} , deck name: ${deck.name}");
                                                    _temp = [];
                                                    _temp.add(deck);
                                                    return deck_widget.Deck(
                                                        width: width,
                                                        deck: deck,
                                                        height: height,
                                                        min: 3,
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                              context, "/deck",
                                                              arguments: {
                                                                "deck": deck,
                                                              });
                                                        },
                                                        path:
                                                            "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png");
                                                  }
                                                  return Container();
                                                }),
                                            if (i + 1 < decks.length)
                                              FutureBuilder(
                                                  future: decks[i + 1],
                                                  builder: (context, deckData) {
                                                    if (deckData.hasData) {
                                                      final deck =
                                                          deckData.data!;
                                                      _temp.add(deck);
                                                      return deck_widget.Deck(
                                                          deck: deck,
                                                          width: width,
                                                          height: height,
                                                          min: 3,
                                                          onTap: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                "/deck",
                                                                arguments: {
                                                                  "deck": deck,
                                                                });
                                                          },
                                                          path:
                                                              "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png");
                                                    }
                                                    return Container();
                                                  }),
                                          ],
                                        ),
                                      ),
                                  ],
                                ));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }));
              return _state;
            },
          )
        : rendered;
  }
}
