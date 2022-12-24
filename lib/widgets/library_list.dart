import 'package:cardflip/data/Repositories/user_decks.dart';
import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/data/card_generator.dart';
import 'package:cardflip/models/deckModel.dart';
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:no_glow_scroll/no_glow_scroll.dart';

import '../data/deck.dart' as deck_data;
import "../widgets/deck.dart" as deck_widget;

// ignore: must_be_immutable

class LibraryList {
  CardGenerator cardgenerator = CardGenerator();
  DeckModel deckModel = DeckModel();
  List<deck_data.Deck> deckList = <deck_data.Deck>[];
  bool filter;
  LibraryList({this.filter = false});
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
  Widget build({String state = "all"}) {
    int counter = 0;
    List<Map<String, Widget>> renderList = [];
    return Consumer(
      builder: (context, ref, child) {
        final height = _responsive(context)["height"];
        final width = _responsive(context)["width"];
        final userID = ref.watch(UserIDProvider);
        final favourites = ref.watch(FavouritesProvider);
        final userPersonalDecks = deckModel.deckByUserID(userID);
        deckList = userPersonalDecks;
        if (state == "all") {
          for (int i = 0; i < favourites.length; i++) {
            deckList.add(deckModel.deckByID(favourites[i]));
          }
        }
        if (state == "others") {
          deckList = [];
          for (int i = 0; i < favourites.length; i++) {
            deckList.add(deckModel.deckByID(favourites[i]));
          }
        }
        if (filter) deckModel.filter(deckList);
        EdgeInsets kpaddingCards =
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15);
        if (counter++ == 0) {
          renderList.add({
            state: Expanded(
                child: (deckList.isEmpty)
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
                          for (int i = 0; i < deckList.length; i += 2)
                            Padding(
                              padding: kpaddingCards,
                              child: Row(
                                mainAxisAlignment: (i + 1 < deckList.length)
                                    ? MainAxisAlignment.spaceBetween
                                    : MainAxisAlignment.start,
                                children: [
                                  deck_widget.Deck(
                                      id: deckList[i].id,
                                      width: width,
                                      height: height,
                                      min: 3,
                                      onTap: () {
                                        GoRouter.of(context).go(
                                            '/Home/Library/Deck/${deckList[i].id}');
                                      },
                                      path:
                                          "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                                  if (i + 1 < deckList.length)
                                    deck_widget.Deck(
                                        id: deckList[i + 1].id,
                                        width: width,
                                        height: height,
                                        min: 3,
                                        onTap: () {
                                          GoRouter.of(context).go(
                                              '/Home/Library/Deck/${deckList[i + 1].id}');
                                        },
                                        path:
                                            "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                                ],
                              ),
                            ),
                        ],
                      )))
          });
          return Expanded(
              child: (deckList.isEmpty)
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
                        for (int i = 0; i < deckList.length; i += 2)
                          Padding(
                            padding: kpaddingCards,
                            child: Row(
                              mainAxisAlignment: (i + 1 < deckList.length)
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.start,
                              children: [
                                deck_widget.Deck(
                                    id: deckList[i].id,
                                    width: width,
                                    height: height,
                                    min: 3,
                                    onTap: () {
                                      GoRouter.of(context).go(
                                          '/Home/Library/Deck/${deckList[i].id}');
                                    },
                                    path:
                                        "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                                if (i + 1 < deckList.length)
                                  deck_widget.Deck(
                                      id: deckList[i + 1].id,
                                      width: width,
                                      height: height,
                                      min: 3,
                                      onTap: () {
                                        GoRouter.of(context).go(
                                            '/Home/Library/Deck/${deckList[i + 1].id}');
                                      },
                                      path:
                                          "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                              ],
                            ),
                          ),
                      ],
                    )));
        } else {
          return renderList[0][state]!;
        }
      },
    );
  }

  // static Widget build({String state = "all"}) {
  //   LibraryList.state = state;
  //   print(deckList);
  //   return consumerWidget(state);
  // }
}
